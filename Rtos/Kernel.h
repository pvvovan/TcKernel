#ifndef RTOS_KERNEL_H_
#define RTOS_KERNEL_H_

#include <stdint.h>
#include "Task.h"


class Kernel final {
    public:
        void StartRtos() {
            __asm("DISABLE");
            __asm("DSYNC");
            uint32_t lower_csa = *current_task->top_of_stack;
            current_task->top_of_stack++;

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

        void AddTask(TaskBase *task) {
            /* Linked list ring */
            if (current_task == nullptr) {
                current_task = task;
                current_task->next = task;
            } else {
                TaskBase *next_task = current_task->next;
                task->next = next_task;
                current_task->next = task;
                current_task = task;
            }
        }

        void SysIsr() {
            current_task->SaveContext();
            ScheduleTask();
            current_task->LoadContext();
            systicks++;
        }

        void delay_ms(uint32_t ms) {
            const uint32_t entry_ticks = systicks;
            while (systicks - entry_ticks < ms) {
                __asm("NOP");
            }
        }


    private:
        volatile uint32_t systicks {0};
        TaskBase *current_task {nullptr};

        void ScheduleTask() {
            current_task = current_task->next;
        }
};

#endif /* RTOS_KERNEL_H_ */
