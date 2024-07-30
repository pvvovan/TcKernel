#ifndef RTOS_KERNEL_H_
#define RTOS_KERNEL_H_

#include <stdint.h>
#include "Task.h"


class Kernel final {
    public:
        void StartRtos() {
            __asm("DISABLE");
            __asm("DSYNC");
            uint32_t lower_csa = *(all_tasks[task_num]->top_of_stack);
            all_tasks[task_num]->top_of_stack++;

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
            all_tasks[task_count++] = task;
        }

        void SysIsr() {
            const uint32_t CALL_DEPTH {1};
            all_tasks[task_num]->SaveContext(CALL_DEPTH);
            ScheduleTask();
            all_tasks[task_num]->LoadContext(CALL_DEPTH);
        }


    private:
        TaskBase *all_tasks[10];
        uint32_t task_count {0};
        uint32_t task_num {0};

        void ScheduleTask() {
            task_num++;
            if (task_num >= task_count) {
                task_num = 0;
            }
        }
};

#endif /* RTOS_KERNEL_H_ */
