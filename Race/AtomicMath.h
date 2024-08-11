#ifndef RACE_ATOMICMATH_H_
#define RACE_ATOMICMATH_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

static inline void atomic_add(uint32_t *data, uint32_t val)
{
    for ( ; ; ) {
        const uint32_t old_data = *data;
        const uint32_t new_data = old_data + val;
        uint64_t swapval {(static_cast<uint64_t>(old_data) << 32) | new_data};

        __asm("CMPSWAP.W    [%1], %0"
                : "=e" (swapval)
                : "a" (data), "0" (swapval)
                : );

        if (static_cast<uint32_t>(swapval) == static_cast<uint32_t>(swapval >> 32)) {
            break;
        }
    }
}

static inline void atomic_sub(uint32_t *data, uint32_t val)
{
    for ( ; ; ) {
        const uint32_t old_data = *data;
        const uint32_t new_data = old_data - val;
        uint64_t swapval {(static_cast<uint64_t>(old_data) << 32) | new_data};

        __asm("CMPSWAP.W    [%1], %0"
                : "=e" (swapval)
                : "a" (data), "0" (swapval)
                : );

        if (static_cast<uint32_t>(swapval) == static_cast<uint32_t>(swapval >> 32)) {
            break;
        }
    }
}

#ifdef __cplusplus
}
#endif

#endif /* RACE_ATOMICMATH_H_ */
