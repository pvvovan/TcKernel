#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelDef.h"
#include "KernelCore2.h"
#include "Kernel.h"
#include "Task.h"
#include "Src.h"
#include "Stm.h"


typedef SRC_STMxSRy<2, 0> SRC_STMSR0_t;
static STM<2> stm = STM<2>();
static Kernel kernel = Kernel();

static volatile uint32_t systicks = 0;

extern "C" void KernelCore2_SysIsr(void)
{
    stm.Isr();
    kernel.SysIsr();
    systicks++;
}

static void delay_ms(uint32_t ms)
{
    const uint32_t entry_ticks = systicks;
    while (systicks - entry_ticks < ms) {
        __asm("NOP");
    }
}

static void task0_c2_blink(void)
{
    IfxPort_setPinMode(IfxPort_P20_12.port, IfxPort_P20_12.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_ms(250);
        IfxPort_setPinState(IfxPort_P20_12.port, IfxPort_P20_12.pinIndex, IfxPort_State_toggled);
    }
}

static Task<256> task0(&task0_c2_blink);

extern "C" void KernelCore2_Start(void)
{
    SRC_STMSR0_t SRC_STMSR0 = SRC_STMSR0_t();
    SRC_STMSR0.EnableService(SYS_IRQ_PRIO, SRC_STMSR0_t::SRC_TOS::CPU2);

    kernel.AddTask(&task0);
    stm.EnableIrq();
    kernel.StartRtos();

    for( ; ; ) { }
}
