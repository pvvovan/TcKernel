#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore1.h"
#include "Kernel.h"
#include "Src.h"
#include "Stm.h"


typedef SRC_STMxSRy<1, 0> SRC_STM1SR0_t;
static STM<1> STM1 = STM<1>();

static volatile uint32_t systicks = 0;

extern "C" void KernelCore1_SysIsr(void)
{
    STM1.HandleIsr();
    systicks++;
}

static inline void delay_c1_ms(uint32_t ms)
{
    const uint32_t entry_ticks = systicks;
    while (systicks - entry_ticks < ms) {
        __asm("NOP");
    }
}

static void task_c1_blink(void)
{
    IfxPort_setPinMode(IfxPort_P33_6.port, IfxPort_P33_6.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_c1_ms(500);
        IfxPort_setPinState(IfxPort_P33_6.port, IfxPort_P33_6.pinIndex, IfxPort_State_toggled);
    }
}

extern "C" void KernelCore1_Start(void)
{
    SRC_STM1SR0_t SRC_STM1SR0 = SRC_STM1SR0_t();
    SRC_STM1SR0.EnableService(SYS_IRQ_PRIO, SRC_STM1SR0_t::SRC_TOS::CPU1);

    STM1.EnableIrq();
    task_c1_blink();
    for( ; ; ) { }
}
