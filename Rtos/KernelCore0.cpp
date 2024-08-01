#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelDef.h"
#include "KernelCore0.h"
#include "Kernel.h"
#include "Task.h"
#include "Src.h"
#include "Stm.h"


typedef SRC_STMxSRy<0, 0> SRC_STMSR0_t;
static STM<0> stm = STM<0>();
static Kernel kernel = Kernel();

extern "C" void KernelCore0_SysIsr(void)
{
    stm.Isr();
    kernel.SysIsr();
}

static void task1_c0_blink()
{
    IfxPort_setPinMode(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        kernel.delay_ms(500);
        IfxPort_setPinState(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_State_toggled);
    }
}

static void task2_c0_blink()
{
    IfxPort_setPinMode(IfxPort_P33_5.port, IfxPort_P33_5.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        kernel.delay_ms(1000);
        IfxPort_setPinState(IfxPort_P33_5.port, IfxPort_P33_5.pinIndex, IfxPort_State_toggled);
    }
}

static Task<512> task1(&task1_c0_blink);
static Task<1024> task2(&task2_c0_blink);

extern "C" void KernelCore0_Start(void)
{
    SRC_STMSR0_t SRC_STMSR0 = SRC_STMSR0_t();
    SRC_STMSR0.EnableService(SYS_IRQ_PRIO, SRC_TOS::CPU0);

    kernel.AddTask(&task1);
    kernel.AddTask(&task2);
    stm.EnableIrq();
    kernel.StartRtos();

    for( ; ; ) { }
}
