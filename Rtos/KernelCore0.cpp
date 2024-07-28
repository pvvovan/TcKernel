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
    STM0.EnableSysIrq();
    for( ; ; ) {
        STM0.HandleIsr();
    }
}
