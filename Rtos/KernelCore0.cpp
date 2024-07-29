/*
 * KernelCore0.cpp
 *
 *  Created on: Jul 28, 2024
 *      Author: pvvov
 */

#include <Src.h>
#include "KernelCore0.h"
#include "Kernel.h"
#include "Stm.h"
#include "Src.h"


typedef SRC_STMxSRy<0, 0> SRC_STM0SR0_t;

static STM<0> STM0 = STM<0>();

extern "C" void KernelCore0_Start(void)
{
    SRC_STM0SR0_t SRC_STM0SR0 = SRC_STM0SR0_t();
    SRC_STM0SR0.EnableService(SYS_IRQ_PRIO, SRC_STM0SR0_t::SRC_TOS::CPU0);

    STM0.EnableIrq();
    for( ; ; ) {

    }
}

volatile uint32_t g_systicks_c0 = 0;
extern "C" void KernelCore0_SysIsr(void)
{
    STM0.HandleIsr();
    g_systicks_c0++;
}
