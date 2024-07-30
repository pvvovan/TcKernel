#ifndef RTOS_KERNEL_H_
#define RTOS_KERNEL_H_

#include <stdint.h>

#define TASK_NO           16
#define STACK_SIZE      1024

class Kernel final {
    public:
        void StartRtos() {
            __asm("DISABLE");
            __asm("DSYNC");
            uint32_t lower_csa = *(all_tasks[0].stack_top);
            all_tasks[0].stack_top++;

            __asm("MTCR    #0xFE00, %0" /* PCXI */
                    :
                    : "d" (lower_csa)
                    : );
            __asm("ISYNC");

            /* Reset call depth counter to avoid trap on RFE */
            uint32_t curr_psw;
            __asm("MFCR    %0, #0xFE04" /* PSW */
                    : "=d" (curr_psw)
                    :
                    : );
            const uint32_t PSW_MSK {0x7FuL};
            curr_psw &= ~PSW_MSK;
            __asm("MTCR    #0xFE04, %0" /* PSW */
                    :
                    : "d" (curr_psw)
                    : );
            __asm("ISYNC");

            /* IRQs are enabled by RFE */
            __asm("RSLCX");
            __asm("RFE");
        }

        void CreateTask(void (*entry)(void)) {
            all_tasks[task_pos].Init(entry);
            task_pos++;
            if (task_pos >= TASK_NO) {
                for(;;);
            }
        }

        void SysIsr() {
            task_pos++;
            if (task_pos >= TASK_NO) {
                task_pos = 0;
            }
        }


    private:
        class Task final {
            uint64_t stack[STACK_SIZE] = { 0 };

          public:
            uint32_t *stack_top {reinterpret_cast<uint32_t *>(&stack[STACK_SIZE - 1])};

            uint32_t * csa_to_address(uint32_t csa) {
                uint32_t csa_addr = (csa & 0xFFFFuL) << 6;
                uint32_t segment = ((csa >> 16) & 0xFu) << 28;
                csa_addr |= segment;
                return reinterpret_cast<uint32_t *>(csa_addr);
            }

            void Init(void (*entry)()) {
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
                p_upper_csa[2] = reinterpret_cast<uint32_t>(stack_top); /* A10; Stack Pointer */
                p_upper_csa[1] = INITIAL_PSW;    /* PSW */
                p_upper_csa[0] = INITIAL_UPPER_PCXI;

                /* Lower Context */
                const uint32_t INITIAL_LOWER_PCXI = 0x00300000uL;
                p_lower_csa[8] = 0; /* A4; Function Parameter Register */
                p_lower_csa[1] = reinterpret_cast<uint32_t>(entry); /* A11; Return Address RA */
                p_lower_csa[0] = INITIAL_LOWER_PCXI | upper_csa; /* PCXI pointing to the Upper context */

                /* Save the link to the CSA to the top of stack */
                stack_top--;
                *stack_top = lower_csa;
            }

            void Save() {

            }
            void Load() {

            }
        };
        Task all_tasks[TASK_NO];
        uint32_t task_pos{0};
};

#endif /* RTOS_KERNEL_H_ */
