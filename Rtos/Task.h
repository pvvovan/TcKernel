#ifndef RTOS_TASK_H_
#define RTOS_TASK_H_

#include <stdint.h>


class TaskBase {
    private:
        const uint32_t CDC_MSK {0x7F};


    protected:
        /* Generation of the Effective Address of a Context Save Area (CSA) */
        uint32_t * csa_to_address(uint32_t csa) {
            uint32_t csa_addr = (csa & 0xFFFFuL) << 6;
            uint32_t segment = ((csa >> 16) & 0xFu) << 28;
            csa_addr |= segment;
            return reinterpret_cast<uint32_t *>(csa_addr);
        }


    public:
        uint32_t *top_of_stack;
        TaskBase(uint32_t *stack_top) : top_of_stack{stack_top} { }
        TaskBase *next {nullptr};

        virtual ~TaskBase() = default;
        TaskBase()                              = delete;
        TaskBase(const TaskBase&)               = delete;
        TaskBase(TaskBase&&)                    = delete;
        TaskBase& operator=(const TaskBase&)    = delete;
        TaskBase& operator=(TaskBase&&)         = delete;

        void SaveContext() {
            __asm("DSYNC");

            uint32_t call_depth;
            __asm("MFCR    %0, #0xFE04" /* PSW Program Status Word */
                    /* Value is incremented on each Call and is decremented on a Return */
                    : "=d" (call_depth)
                    :
                    : );
            call_depth &= CDC_MSK;

            uint32_t lower_csa;
            /* PCXI Previous Context Information and Pointer Register */
            __asm("MFCR    %0, #0xFE00"
                    : "=d" (lower_csa)
                    :
                    : );

            /* CSAs are linked together through a Link Word (PCXI): the first element in SCA */
            uint32_t *p_csa = csa_to_address(lower_csa);
            for (uint32_t i = 0; i < (call_depth - 1); i++) {
                p_csa = csa_to_address(p_csa[0]);
            }
            lower_csa = p_csa[0];

            uint32_t *p_lower_csa = csa_to_address(lower_csa);
            uint32_t *p_upper_csa = csa_to_address(p_lower_csa[0]);
            this->top_of_stack = reinterpret_cast<uint32_t *>(p_upper_csa[2]); /* A[10] (SP) */

            /* Save PCXI (Link Word) on the stack */
            this->top_of_stack--;
            *this->top_of_stack = lower_csa;
        }

        void LoadContext() {
            __asm("DSYNC");
            uint32_t loaded_lower_csa = *this->top_of_stack;
            this->top_of_stack++; /* Now it points to A[10] (SP) */

            uint32_t call_depth;
            __asm("MFCR    %0, #0xFE04" /* PSW Program Status Word */
                    /* Value is incremented on each Call and is decremented on a Return */
                    : "=d" (call_depth)
                    :
                    : );
            call_depth &= CDC_MSK;

            uint32_t lower_csa;
            /* PCXI Previous Context Information and Pointer Register */
            __asm("MFCR    %0, #0xFE00"
                    : "=d" (lower_csa)
                    :
                    : );

            /* CSAs are linked together through a Link Word (PCXI): the first element in SCA */
            uint32_t *p_csa = csa_to_address(lower_csa);
            for (uint32_t i = 0; i < (call_depth - 1); i++) {
                p_csa = csa_to_address(p_csa[0]);
            }

            /* Replace task lower CSA in the call stack */
            p_csa[0] = loaded_lower_csa;
        }
};

template<uint32_t stack_size>
class Task final : public TaskBase {
        static_assert(stack_size > 127, "Too small stack size");
        uint64_t stack[stack_size] = { 0 };
        void (*entry)(void);

        static void run(void (*entry)(void)) {
            entry();
            for(;;);
        }

        void init_stack() {
            __asm("DISABLE");
            __asm("DSYNC");

            uint32_t lower_csa;
            /* The Free CSA List Head Pointer (FCX) register holds the free CSA list head pointer.
             * This always points to an available CSA */
            __asm("MFCR    %0, #0xFE38" /* FCX */
                    : "=d" (lower_csa)
                    :
                    : );

            /* Upper CSA is linked through a Link Word */
            uint32_t *p_lower_csa = csa_to_address(lower_csa);
            uint32_t upper_csa = p_lower_csa[0];
            uint32_t *p_upper_csa = csa_to_address(upper_csa);

            /* Consume two CSAs from the free CSA list */
            __asm("MTCR    #0xFE38, %0" /* Free CSA List Head Pointer (FCX) */
                    :
                    : "d" (p_upper_csa[0])
                    : );
            __asm("ISYNC");
            __asm("ENABLE");

            /* Prepare Upper Context */
            const uint32_t PSW_IO {2uL << 10}; /* Supervisor mode */
            const uint32_t PSW_CDE {1uL << 7}; /* Enable call depth counter */
            const uint32_t INITIAL_PSW {PSW_IO | PSW_CDE};
            const uint32_t INITIAL_UPPER_PCXI {1uL << 21}; /* Previous Interrupt Enable */
            p_upper_csa[2] = reinterpret_cast<uint32_t>(top_of_stack); /* A10; Stack Pointer */
            p_upper_csa[1] = INITIAL_PSW;
            p_upper_csa[0] = INITIAL_UPPER_PCXI;

            /* Prepare Lower Context */
            const uint32_t PCXI_PIE {1uL << 21}; /* Previous Interrupt Enable */
            const uint32_t PCXI_UL {1uL << 20}; /* Upper Context Tag */
            const uint32_t INITIAL_LOWER_PCXI {PCXI_PIE | PCXI_UL};
            p_lower_csa[8] = reinterpret_cast<uint32_t>(entry); // A4; Function Parameter Register
            p_lower_csa[1] = reinterpret_cast<uint32_t>(&Task::run); /* A11; Return Address RA */
            p_lower_csa[0] = INITIAL_LOWER_PCXI | upper_csa; /* PCXI pointing to Upper context */

            /* Save the link to the CSA on the top of stack */
            top_of_stack--;
            *top_of_stack = lower_csa;
        }


    public:
        Task(void (*entry)(void)) : TaskBase(reinterpret_cast<uint32_t *>(&stack[stack_size - 1]))
        {
            this->entry = entry;
            init_stack();
        }
        ~Task() override = default;
        Task()                          = delete;
        Task(const Task&)               = delete;
        Task(Task&&)                    = delete;
        Task& operator=(const Task&)    = delete;
        Task& operator=(Task&&)         = delete;
};

#endif /* RTOS_TASK_H_ */
