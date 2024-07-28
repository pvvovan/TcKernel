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


template <uint32_t CORE>
struct core_range :
   std::integral_constant< bool, (CORE < 6) >{};

template <uint32_t core>//, std::enable_if<core_range<core>::value::type >
class STM final
{   
    private:
    static const uint32_t STM_BASE {0xF0001000uL};
    static const uint32_t STM_SIZE {0x100};
    static_assert(core < 6, "Core out of range");

    public:
    const volatile uint32_t& TIM0 {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x10)};
};

#endif /* STM_STM_H_ */
