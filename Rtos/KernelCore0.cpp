#include "Port/Io/IfxPort_Io.h"
#include "IfxPort_PinMap.h"

#include "KernelCore0.h"
#include "Kernel.h"
#include "Count.h"
#include "Dma.h"


#define BUF_SIZE_PWR2       (5u) /* Buffer size is 2^5 (32 bytes): 8 elements of uint32_t */
#define BUF_SIZE_BYTES      (1u << BUF_SIZE_PWR2)
#define BUF_SIZE_ELEMS      (BUF_SIZE_BYTES / sizeof(uint32_t))

static constexpr uint8_t STM_DMA_PRIO {61};
static Kernel<0> kernel{};
static STM<5> STM5{};

extern "C" void KernelCore0_SysIsr(void)
{
    kernel.SysIsr();
}

__align(BUF_SIZE_BYTES) volatile uint32_t g_tim_cnt[BUF_SIZE_ELEMS] = { 0 };

static void dma_init()
{
    DMA<STM_DMA_PRIO>::DADR = &g_tim_cnt[0];
    DMA<STM_DMA_PRIO>::SADR = &STM5.TIM<0>();


    /* 010B: 32-bit data width for moves selected */
    DMA<STM_DMA_PRIO>::CHCFGR.CHDW = 2;

    /** 1B: Continuous_Mode, is selected for DMA channel.
     * After a DMA transaction, bit TSR.HTRE remains set. */
    DMA<STM_DMA_PRIO>::CHCFGR.CHMODE = 1;

    /** 0B: DMA channel TSR.CH is reset after the start of each DMA transfer.
     * A DMA request is required for each DMA transfer. */
    /** 1B: DMA channel TSR.CH is reset when CHSR.TCOUNT = 0 and after the
     * completion of the last DMA transfer (i.e. on completion of the DMA
     * transaction). One DMA request starts a complete DMA transaction. */
    DMA<STM_DMA_PRIO>::CHCFGR.RROAT = 0;

    /** If CHCFGR.TREL = 0 or if CHCFGR.TREL = 1 then ME CHSR.TCOUNT will be
     * loaded with 1 when a new DMA transaction is started (at least one DMA
     * transfer must be executed per DMA transaction). */
    DMA<STM_DMA_PRIO>::CHCFGR.TREL = 1;


    DMA<STM_DMA_PRIO>::ADICR.INCS = 1; /* 1B: Address offset will be added */
    DMA<STM_DMA_PRIO>::ADICR.INCD = 1; /* 1B: Address offset will be added */
    DMA<STM_DMA_PRIO>::ADICR.DCBE = 1; /* 1B: Destination circular buffer enabled */
    DMA<STM_DMA_PRIO>::ADICR.SCBE = 1; /* 1B: Source circular buffer enabled */
    DMA<STM_DMA_PRIO>::ADICR.CBLD = BUF_SIZE_PWR2; /* Circular buffer is 2^CBLD bytes */

    DMA<STM_DMA_PRIO>::TSR.ECH = 1; /* Enable DMA Channel Hardware Transaction Request */

    SRC_STMxSRy<5, ICR::Irq_1> SRC_STM5SR1{};
    SRC_STM5SR1.EnableService(STM_DMA_PRIO, SRC_TOS::DMA);

    STM5.Enable(ICR::Irq_1);
}

static void task1_c0_blink()
{
    dma_init();

    IfxPort_setPinMode(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_Mode_outputPushPullGeneral);
    for ( ; ; ) {
        kernel.delay_ms(500);
        IfxPort_setPinState(IfxPort_P33_4.port, IfxPort_P33_4.pinIndex, IfxPort_State_toggled);
        STM5.CMP<0>() = STM5.TIM<0>() + 0.4 * STM5.TICKS_1MS;
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
