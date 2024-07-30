#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore0.h"
#include "Kernel.h"
#include "Src.h"
#include "Stm.h"


typedef SRC_STMxSRy<0, 0> SRC_STM0SR0_t;
static STM<0> STM0 = STM<0>();

static volatile uint32_t systicks = 0;

extern "C" void KernelCore0_SysIsr(void)
{
    STM0.HandleIsr();
    systicks++;
}

static inline void delay_c0_ms(uint32_t ms)
{
    const uint32_t entry_ticks = systicks;
    while (systicks - entry_ticks < ms) {
        __asm("NOP");
    }
}

static void task_c0_blink(void)
{
    IfxPort_setPinMode(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_c0_ms(500);
        IfxPort_setPinState(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_State_toggled);
    }
}

extern "C" void KernelCore0_Start(void)
{
    SRC_STM0SR0_t SRC_STM0SR0 = SRC_STM0SR0_t();
    SRC_STM0SR0.EnableService(SYS_IRQ_PRIO, SRC_STM0SR0_t::SRC_TOS::CPU0);

    STM0.EnableIrq();
    task_c0_blink();
    for( ; ; ) { }
}
