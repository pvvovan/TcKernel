#include "Count.h"
#include "AtomicMath.h"


long long Count::counter{0};
uint32_t Count::lock {UNLOCKED};

static uint32_t s_intval {0};

void Count::spin_lock() {
    uint64_t val {(static_cast<uint64_t>(UNLOCKED) << 32) | LOCKED};
    for ( ; ; ) {
        __asm("DISABLE");
        __asm("CMPSWAP.W    [%1], %0"
                : "=e" (val)
                : "a" (&Count::lock), "0" (val)
                : );
        if (static_cast<uint32_t>(val) == static_cast<uint32_t>(val >> 32)) {
            break;
        }
        __asm("ENABLE");
        __asm("NOP");
        __asm("NOP");
        __asm("NOP");
    }
    __asm("DSYNC");
}

void Count::spin_unlock() {
    __asm("DSYNC");
    lock = UNLOCKED;
    __asm("ENABLE");
}

void Count::Race() {
    for (long long i{0}; i < 100*1000*1000; i++) {
        spin_lock();
        Count::counter += 1000;
        spin_unlock();

        atomic_add(&s_intval, 11);
        atomic_sub(&s_intval, 10);
    }
    for(;;);
}

Task<256> g_task0_core0 {&Count::Race};
Task<256> g_task1_core0 {&Count::Race};
Task<256> g_task2_core0 {&Count::Race};

Task<256> g_task0_core1 {&Count::Race};
Task<256> g_task1_core1 {&Count::Race};
Task<256> g_task2_core1 {&Count::Race};

Task<256> g_task0_core2 {&Count::Race};
Task<256> g_task1_core2 {&Count::Race};
Task<256> g_task2_core2 {&Count::Race};
