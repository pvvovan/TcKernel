#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore5.h"
#include "Kernel.h"
#include "Count.h"


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

static void SingleWriting() {
    for (long i = 0; i < 100*1000*1000; i++) {
        SingleWriterLock write_lock {g_sync_handle};
        DataPack dp;
        dp.a = i;
        dp.b = dp.a + 1;
        dp.c = dp.b + 2;
        g_data_pack = dp;
    }
    for(;;);
}
static Task<256> g_tasksw_core5 {&SingleWriting};

extern "C" void KernelCore5_Start(void)
{
    kernel.AddTask(&task1);
    kernel.AddTask(&task2);
    kernel.AddTask(&g_tasksw_core5);
    kernel.StartRtos();
    for( ; ; ) { /* kernel.StartRtos() shall never return */ }
}
