#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore0.h"
#include "Kernel.h"
#include "Count.h"
#include "Dma.h"


static constexpr uint8_t STM_DMA_PRIO {61};
static Kernel<0> kernel{};

extern "C" void KernelCore0_SysIsr(void)
{
    kernel.SysIsr();
}

volatile uint32_t g_tim_cnt[4] = { 0 };
static void dma_init()
{
    DMA::DADR<STM_DMA_PRIO>::R() = &g_tim_cnt[0];
    DMA::SADR<STM_DMA_PRIO>::R() = &STM<5>().TIM<0>();


    /* 010B 32-bit data width for moves selected */
    DMA::CHCFGR<STM_DMA_PRIO>::R().CHDW = 2;

    /* 1B Continuous_Mode, is selected for DMA channel.
     * After a DMA transaction, bit TSR.HTRE remains set. */
    DMA::CHCFGR<STM_DMA_PRIO>::R().CHMODE = 1;

    /* 1B DMA channel TSR.CH is reset when CHSR.TCOUNT = 0 and after the
     * completion of the last DMA transfer (i.e. on completion of the DMA
     * transaction). One DMA request starts a complete DMA transaction. */
    DMA::CHCFGR<STM_DMA_PRIO>::R().RROAT = 1;

    /* If CHCFGR.TREL = 0 or if CHCFGR.TREL = 1 then ME CHSR.TCOUNT will be
     * loaded with 1 when a new DMA transaction is started (at least one DMA
     * transfer must be executed per DMA transaction). */
    DMA::CHCFGR<STM_DMA_PRIO>::R().TREL = 1;


    DMA::ADICR<STM_DMA_PRIO>::R().INCS = 1; /* 1B Address offset will be added */
    DMA::ADICR<STM_DMA_PRIO>::R().INCD = 1; /* 1B Address offset will be added */
    DMA::ADICR<STM_DMA_PRIO>::R().DCBE = 1; /* 1B Destination circular buffer enabled */
    DMA::ADICR<STM_DMA_PRIO>::R().SCBE = 1; /* 1B Source circular buffer enabled */

    DMA::TSR<STM_DMA_PRIO>::R().ECH = 1; /* Enable DMA Channel Hardware Transaction Request */

    constexpr ICR irq {ICR::Irq_1};
    SRC_STMxSRy<5, irq> SRC_STM5SR1{};
    SRC_STM5SR1.EnableService(STM_DMA_PRIO, SRC_TOS::DMA);

    STM<5> STM5{};
    STM5.Enable(irq);
}

static void task1_c0_blink()
{
    dma_init();

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
    kernel.AddTask(&g_task0_core0);
    kernel.AddTask(&g_task1_core0);
    kernel.AddTask(&g_task2_core0);
    kernel.StartRtos();
    for( ; ; ) { /* kernel.StartRtos() shall never return */ }
}
