#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore2.h"
#include "Kernel.h"


static Kernel<2> kernel{};

extern "C" void KernelCore2_SysIsr(void)
{
    kernel.SysIsr();
}

static void task0_c2_blink(void)
{
    IfxPort_setPinMode(IfxPort_P20_12.port, IfxPort_P20_12.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        kernel.delay_ms(250);
        IfxPort_setPinState(IfxPort_P20_12.port, IfxPort_P20_12.pinIndex, IfxPort_State_toggled);
    }
}

static Task<256> task0(&task0_c2_blink);

extern "C" void KernelCore2_Start(void)
{
    kernel.AddTask(&task0);
    kernel.StartRtos();
    for( ; ; ) { /* kernel.StartRtos() shall never return */ }
}
