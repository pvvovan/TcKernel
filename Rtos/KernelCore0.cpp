/*
 * KernelCore0.cpp
 *
 *  Created on: Jul 28, 2024
 *      Author: pvvov
 */

#include "KernelCore0.h"
#include "Stm.h"

extern "C" void KernelCore0_Start(void)
{
    STM<0> STM0 = STM<0>();
    STM<5> STM5 = STM<5>();
    volatile uint32_t tim0;
    volatile uint32_t tim5;
    for( ; ; ) {
        tim0 = STM0.TIM0;
        tim5 = STM5.TIM0;
    }
}
