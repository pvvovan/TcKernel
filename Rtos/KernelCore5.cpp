#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore5.h"
#include "Kernel.h"


static Kernel<5> kernel{};

extern "C" void KernelCore5_SysIsr(void)
{
    kernel.SysIsr();
}

static void task1_c5_blink(void)
{
    IfxPort_setPinMode(IfxPort_P20_13.port, IfxPort_P20_13.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        IfxPort_setPinState(IfxPort_P20_13.port, IfxPort_P20_13.pinIndex, IfxPort_State_high);
        kernel.delay_ms(50);
        IfxPort_setPinState(IfxPort_P20_13.port, IfxPort_P20_13.pinIndex, IfxPort_State_low);
        kernel.delay_ms(50);
    }
}

static void task2_c5_blink(void)
{
    IfxPort_setPinMode(IfxPort_P20_14.port, IfxPort_P20_14.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        IfxPort_setPinState(IfxPort_P20_14.port, IfxPort_P20_14.pinIndex, IfxPort_State_high);
        kernel.delay_ms(125);
        IfxPort_setPinState(IfxPort_P20_14.port, IfxPort_P20_14.pinIndex, IfxPort_State_low);
        kernel.delay_ms(125);
    }
}

static Task<256> task1(&task1_c5_blink);
static Task<256> task2(&task2_c5_blink);

extern "C" void KernelCore5_Start(void)
{
    kernel.AddTask(&task1);
    kernel.AddTask(&task2);
    kernel.StartRtos();
    for( ; ; ) { /* kernel.StartRtos() shall never return */ }
}
