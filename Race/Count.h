#ifndef RACE_COUNT_H_
#define RACE_COUNT_H_

#include "Task.h"
#include <stdint.h>

class Count
{
        Count() = delete;
        static long long counter;

        static constexpr uint32_t LOCKED {1};
        static constexpr uint32_t UNLOCKED {0};
        static uint32_t lock;

        static void spin_lock();
        static void spin_unlock();

    public:
        static void Race();
};

extern Task<256> g_task0_core0;
extern Task<256> g_task1_core0;
extern Task<256> g_task2_core0;

extern Task<256> g_task0_core1;
extern Task<256> g_task1_core1;
extern Task<256> g_task2_core1;

extern Task<256> g_task0_core2;
extern Task<256> g_task1_core2;
extern Task<256> g_task2_core2;

#endif /* RACE_COUNT_H_ */
