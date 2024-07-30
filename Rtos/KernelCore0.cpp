#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelDef.h"
#include "KernelCore0.h"
#include "Kernel.h"
#include "Task.h"
#include "Src.h"
#include "Stm.h"


typedef SRC_STMxSRy<0, 0> SRC_STM0SR0_t;
static STM<0> STM0 = STM<0>();
static Kernel kernel0 = Kernel();

static volatile uint32_t systicks = 0;
extern "C" void KernelCore0_SysIsr(void)
{
    uint32_t isr_cdc;
    __asm("MFCR    %0, #0xFE04" /* PSW */
            : "=d" (isr_cdc)
            :
            : );
    isr_cdc &= TaskBase::CDC_MSK;
    STM0.Isr();
    kernel0.SysIsr(isr_cdc);
    systicks++;
}

static void delay_c0_ms(uint32_t ms)
{
    const uint32_t entry_ticks = systicks;
    while (systicks - entry_ticks < ms) {
        __asm("NOP");
    }
}

static void task1_c0_blink()
{
    IfxPort_setPinMode(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_c0_ms(500);
        IfxPort_setPinState(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_State_toggled);
    }
}

static void task2_c0_blink()
{
    IfxPort_setPinMode(IfxPort_P33_5.port, IfxPort_P33_5.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_c0_ms(1000);
        IfxPort_setPinState(IfxPort_P33_5.port, IfxPort_P33_5.pinIndex, IfxPort_State_toggled);
    }
}

static Task<512> task1(&task1_c0_blink);
static Task<1024> task2(&task2_c0_blink);

extern "C" void KernelCore0_Start(void)
{
    SRC_STM0SR0_t SRC_STM0SR0 = SRC_STM0SR0_t();
    SRC_STM0SR0.EnableService(SYS_IRQ_PRIO, SRC_STM0SR0_t::SRC_TOS::CPU0);

    kernel0.AddTask(&task1);
    kernel0.AddTask(&task2);
    STM0.EnableIrq();
    kernel0.StartRtos();

    for( ; ; ) { }
}
