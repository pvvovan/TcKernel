/*
 * Task.h
 *
 *  Created on: Jul 30, 2024
 *      Author: pvvov
 */

#ifndef RTOS_TASK_H_
#define RTOS_TASK_H_

#include <stdint.h>


class TaskBase {
    public:
        static const uint32_t CDC_MSK {0x7F};
        uint32_t *top_of_stack;
        TaskBase(uint32_t *stack_top) : top_of_stack{stack_top} { }
        TaskBase *next {nullptr};
        virtual ~TaskBase() = default;
        TaskBase() = delete;
        TaskBase(const TaskBase&) = delete;
        TaskBase(TaskBase&&) = delete;
        TaskBase& operator=(const TaskBase&) = delete;
        TaskBase& operator=(TaskBase&&) = delete;

        void SaveContext(uint32_t depth) {
            __asm("DSYNC");
            uint32_t lower_csa;
            __asm("MFCR    %0, #0xFE00" /* PCXI */
                    : "=d" (lower_csa)
                    :
                    : );
            uint32_t *p_csa = csa_to_address(lower_csa);
            for (uint32_t i = 0; i < (depth - 1); i++) {
                p_csa = csa_to_address(p_csa[0]);
            }
            lower_csa = p_csa[0];
            uint32_t *p_lower_csa = csa_to_address(lower_csa);
            uint32_t *p_upper_csa = csa_to_address(p_lower_csa[0]);
            this->top_of_stack = reinterpret_cast<uint32_t *>(p_upper_csa[2]);
            this->top_of_stack--;
            *this->top_of_stack = lower_csa;
        }

        void LoadContext(uint32_t depth) {
            __asm("DSYNC");
            uint32_t new_lower_csa = *this->top_of_stack;
            this->top_of_stack++;

            uint32_t lower_csa;
            __asm("MFCR    %0, #0xFE00" /* PCXI */
                    : "=d" (lower_csa)
                    :
                    : );
            uint32_t *p_csa = csa_to_address(lower_csa);
            for (uint32_t i = 0; i < (depth - 1); i++) {
                p_csa = csa_to_address(p_csa[0]);
            }
            p_csa[0] = new_lower_csa;
        }

        uint32_t * csa_to_address(uint32_t csa) {
            uint32_t csa_addr = (csa & 0xFFFFuL) << 6;
            uint32_t segment = ((csa >> 16) & 0xFu) << 28;
            csa_addr |= segment;
            return reinterpret_cast<uint32_t *>(csa_addr);
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
            __asm("MFCR    %0, #0xFE38" /* FCX */
                    : "=d" (lower_csa)
                    :
                    : );

            uint32_t *p_lower_csa = csa_to_address(lower_csa);
            uint32_t upper_csa = p_lower_csa[0];
            uint32_t *p_upper_csa = csa_to_address(upper_csa);

            __asm("MTCR    #0xFE38, %0" /* FCX */
                    :
                    : "d" (p_upper_csa[0])
                    : );
            __asm("ISYNC");
            __asm("ENABLE");

            /* Upper Context */
            const uint32_t INITIAL_PSW = 0x000008FFuL;
            const uint32_t INITIAL_UPPER_PCXI = 0x00200000uL;
            p_upper_csa[2] = reinterpret_cast<uint32_t>(top_of_stack); /* A10; Stack Pointer */
            p_upper_csa[1] = INITIAL_PSW;    /* PSW */
            p_upper_csa[0] = INITIAL_UPPER_PCXI;

            /* Lower Context */
            const uint32_t INITIAL_LOWER_PCXI = 0x00300000uL;
            p_lower_csa[8] = reinterpret_cast<uint32_t>(entry); /* A4; Function Parameter Register */
            p_lower_csa[1] = reinterpret_cast<uint32_t>(Task::run); /* A11; Return Address RA */
            p_lower_csa[0] = INITIAL_LOWER_PCXI | upper_csa; /* PCXI pointing to the Upper context */

            /* Save the link to the CSA to the top of stack */
            top_of_stack--;
            *top_of_stack = lower_csa;
        }


    public:
        Task(void (*entry)(void)) : TaskBase(reinterpret_cast<uint32_t *>(&stack[stack_size - 1])) {
            this->entry = entry;
            init_stack();
        }
        ~Task() override = default;
        Task() = delete;
        Task(const Task&) = delete;
        Task(Task&&) = delete;
        Task& operator=(const Task&) = delete;
        Task& operator=(Task&&) = delete;
};

#endif /* RTOS_TASK_H_ */
