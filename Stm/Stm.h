/*
 * Stm.h
 *
 *  Created on: Jul 28, 2024
 *      Author: pvvov
 */

#ifndef STM_STM_H_
#define STM_STM_H_

#include <stdint.h>
#include <type_traits>


/* System Timer (STM) is designed for global system timing applications
 * requiring both high precision and long period. */
template<uint32_t core>
class STM final
{   
    private:
    static const uint32_t STM_BASE {0xF0001000uL};
    static const uint32_t STM_SIZE {0x100};
    static_assert(core < 6, "Core out of range");


    public:
    static const uint32_t TICKS_1MS {100000};

    /* Registers TIM0 to TIM6 provide 32-bit views at varying resolutions of the underlying STM counter */
    template<uint32_t x>
    volatile uint32_t& TIM() {
        static_assert(x < 7, "TIM register is not available");
        return *reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x10 + x * 4);
    }

    /* The compare register CMPx holds up to 32-bits; its value is compared to the value of the STM */
    template<uint32_t x>
    volatile uint32_t& CMP() {
        static_assert(x < 2, "CMP register is not available");
        return *reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x30 + x * 4);
    }

    /* The STM Compare Match Control Register controls the parameters of the compare logic */
    volatile uint32_t& CMCON {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x38)};
};

#endif /* STM_STM_H_ */
