#ifndef RTOS_KERNEL_H_
#define RTOS_KERNEL_H_

#include <stdint.h>
#include "Task.h"


class Kernel final {
    public:
        void StartRtos() {
            __asm("DISABLE");
            __asm("DSYNC");
            task_curr = task_tail;
            uint32_t lower_csa = *(task_curr->top_of_stack);
            task_curr->top_of_stack++;

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
            task->next = task_tail;
            task_tail = task;
        }

        void SysIsr(const uint32_t isr_cdc) {
            task_curr->SaveContext(isr_cdc);
            ScheduleTask();
            task_curr->LoadContext(isr_cdc);
        }


    private:
        TaskBase *task_tail {nullptr};
        TaskBase *task_curr {nullptr};

        void ScheduleTask() {
            task_curr = task_curr->next;
            if (task_curr == nullptr) {
                task_curr = task_tail;
            }
        }
};

#endif /* RTOS_KERNEL_H_ */
