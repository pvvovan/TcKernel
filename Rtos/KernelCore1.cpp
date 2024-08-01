#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelDef.h"
#include "KernelCore1.h"
#include "Kernel.h"
#include "Task.h"
#include "Src.h"
#include "Stm.h"


typedef SRC_STMxSRy<1, 0> SRC_STMSR0_t;
static STM<1> stm = STM<1>();
static Kernel kernel = Kernel();

static volatile uint32_t systicks = 0;

extern "C" void KernelCore1_SysIsr(void)
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

static void task1_c1_blink(void)
{
    IfxPort_setPinMode(IfxPort_P33_6.port, IfxPort_P33_6.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_ms(500);
        IfxPort_setPinState(IfxPort_P33_6.port, IfxPort_P33_6.pinIndex, IfxPort_State_toggled);
    }
}

static void task2_c1_blink(void)
{
    IfxPort_setPinMode(IfxPort_P33_7.port, IfxPort_P33_7.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_ms(1000);
        IfxPort_setPinState(IfxPort_P33_7.port, IfxPort_P33_7.pinIndex, IfxPort_State_toggled);
    }
}

static void task3_c1_blink(void)
{
    IfxPort_setPinMode(IfxPort_P20_11.port, IfxPort_P20_11.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        delay_ms(167);
        IfxPort_setPinState(IfxPort_P20_11.port, IfxPort_P20_11.pinIndex, IfxPort_State_toggled);
    }
}

static Task<256> task1(&task1_c1_blink);
static Task<256> task2(&task2_c1_blink);
static Task<256> task3(&task3_c1_blink);

extern "C" void KernelCore1_Start(void)
{
    SRC_STMSR0_t SRC_STMSR0 = SRC_STMSR0_t();
    SRC_STMSR0.EnableService(SYS_IRQ_PRIO, SRC_STMSR0_t::SRC_TOS::CPU1);

    kernel.AddTask(&task1);
    kernel.AddTask(&task2);
    kernel.AddTask(&task3);
    stm.EnableIrq();
    kernel.StartRtos();

    for( ; ; ) { }
}
