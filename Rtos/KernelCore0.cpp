#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore0.h"
#include "Kernel.h"


static Kernel<0> kernel{};

extern "C" void KernelCore0_SysIsr(void)
{
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
    kernel.AddTask(&task1);
    kernel.AddTask(&task2);
    kernel.StartRtos();
    for( ; ; ) { /* kernel.StartRtos() shall never return */ }
}
