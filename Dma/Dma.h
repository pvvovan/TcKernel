#ifndef DMA_DMA_H_
#define DMA_DMA_H_

#include <stdint.h>


namespace DMA {

static constexpr uint32_t BASE {0xF0010000};

/* DMA Channel c Transaction State Register */
template<uint8_t c>
class TSR final {
      static_assert(c < 128, "DMA channel does not exist");
      TSR();

    public:
            volatile uint8_t RST    : 1; /* DMA Channel Reset */
      const volatile uint8_t HTRE   : 1; /* DMA Channel Hardware Request Enable */
      const volatile uint8_t TRL    : 1; /* DMA Channel Transaction/Transfer Request Lost */
      const volatile uint8_t CH     : 1; /* DMA Channel Transaction Request State */
            volatile uint8_t ETRL   : 1; /* Enable DMA Channel Transaction/Transfer Request Lost Interrupt */
                     uint8_t        : 3; /* Reserved */
            volatile uint8_t HLTREQ : 1; /* Enable DMA Channel Transaction/Transfer Request Lost Interrupt */
      const volatile uint8_t HLTACK : 1; /* DMA Channel Halt Acknowledge */
                     uint8_t        : 6; /* Reserved */
            volatile uint8_t ECH    : 1; /* Enable DMA Channel Hardware Transaction Request */
            volatile uint8_t DCH    : 1; /* Disable DMA Channel Hardware Transaction Request */
            volatile uint8_t CTL    : 1; /* Clear DMA Channel Transaction/Transfer Request Lost */
                     uint8_t        : 5; /* Reserved */
            volatile uint8_t HLTCLR : 1; /* Clear DMA Channel Halt Request and Acknowledge */
                     uint8_t        : 7; /* Reserved */

      static TSR & R() {
          return *reinterpret_cast<TSR *>(BASE + 0x1E00 + c * 4);
      }
};

/* DMARAM Channel c Source Address Register */
template<uint8_t c>
class SADR final {
        static_assert(c < 128, "DMA channel does not exist");
        SADR();

    public:
        /* 32-bit source address */
        static uint32_t volatile * & R() {
            return *reinterpret_cast<uint32_t volatile **>(BASE + 0x2008 + c * 0x20);
        }
};

/* DMARAM Channel c Destination Address Register */
template<uint8_t c>
class DADR final {
        static_assert(c < 128, "DMA channel does not exist");
        DADR();

    public:
        /* 32-bit destination address */
        static uint32_t volatile * & R() {
            return *reinterpret_cast<uint32_t volatile **>(BASE + 0x200C + c * 0x20);
        }
};

/* DMARAM Channel c Address and Interrupt Control Register */
template<uint8_t c>
class ADICR final {
        static_assert(c < 128, "DMA channel does not exist");
        ADICR();

    public:
        volatile uint32_t SMF    : 3; /* Source Address Modification Factor */
        volatile uint32_t INCS   : 1; /* Increment of Source Address */
        volatile uint32_t DMF    : 3; /* Destination Address Modification Factor */
        volatile uint32_t INCD   : 1; /* Increment of Destination Address */
        volatile uint32_t CBLS   : 4; /* Circular Buffer Length Source */
        volatile uint32_t CBLD   : 4; /* Circular Buffer Length Destination */
        volatile uint32_t SHCT   : 4; /* Shadow Control */
        volatile uint32_t SCBE   : 1; /* Source Circular Buffer Enable */
        volatile uint32_t DCBE   : 1; /* Destination Circular Buffer Enable */
        volatile uint32_t STAMP  : 1; /* Time Stamp */
                 uint32_t        : 1; /* Reserved */
        volatile uint32_t WRPSE  : 1; /* Wrap Source Enable */
        volatile uint32_t WRPDE  : 1; /* Wrap Destination Enable */
        volatile uint32_t INTCT  : 2; /* Interrupt Control */
        volatile uint32_t IRDV   : 4; /* Interrupt Raise Detect Value */

        static ADICR & R() {
            return *reinterpret_cast<ADICR *>(BASE + 0x2010 + c * 0x20);
        }
};

/* DMARAM Channel c Address and Interrupt Control Register */
template<uint8_t c>
class CHCFGR final {
        static_assert(c < 128, "DMA channel does not exist");
        CHCFGR();

    public:
        volatile uint32_t TREL   : 14; /* Transfer Reload Value */
        volatile uint32_t        :  2; /* Reserved */
        volatile uint32_t BLKM   :  3; /* Block Mode */
        volatile uint32_t RROAT  :  1; /* Reset Request Only After Transaction */
        volatile uint32_t CHMODE :  1; /* Channel Operation Mode */
        volatile uint32_t CHDW   :  3; /* Channel Data Width */
        volatile uint32_t PATSEL :  3; /* Pattern Select */
        volatile uint32_t SWAP   :  1; /* Swap Data CRC Byte Order */
        volatile uint32_t PRSEL  :  1; /* Peripheral Request Select */
        volatile uint32_t        :  3; /* Reserved */

        static volatile CHCFGR & R() {
            return *reinterpret_cast<volatile CHCFGR *>(BASE + 0x2014 + c * 0x20);
        }
};

/* DMARAM Channel c Control and Status Register */
template<uint8_t c>
class CHCSR final {
        static_assert(c < 128, "DMA channel does not exist");
        CHCSR();

    public:
        const volatile uint16_t TCOUNT : 14; /* DMA channel status transfer count updated after DMARAM write back */
                        uint8_t        :  1; /* Reserved */
        const volatile  uint8_t LXO    :  1; /* Old Value of Pattern Detection */
        const volatile  uint8_t WRPS   :  1; /* Wrap Source Buffer */
        const volatile  uint8_t WRPD   :  1; /* Wrap Destination Buffer */
        const volatile  uint8_t ICH    :  1; /* Interrupt from Channel */
        const volatile  uint8_t IPM    :  1; /* Pattern Detection from Channel */
                        uint8_t        :  2; /* Reserved */
        const volatile  uint8_t BUFFER :  1; /* DMA Double Buffering Active Buffer */
              volatile  uint8_t FROZEN :  1; /* DMA Double Buffering Frozen Buffer */
              volatile  uint8_t SWB    :  1; /* DMA Double Buffering Switch Buffer */
              volatile  uint8_t CWRP   :  1; /* Clear Wrap Buffer Interrupt */
              volatile  uint8_t CICH   :  1; /* Clear Interrupt for DMA Channel */
              volatile  uint8_t SIT    :  1; /* Set Interrupt Trigger for DMA Channel */
                        uint8_t        :  3; /* Reserved */
              volatile  uint8_t SCH    :  1; /* Set Transaction Request */

        static CHCSR & R() {
            return *reinterpret_cast<CHCSR *>(BASE + 0x201C + c * 0x20);
        }
};

}

#endif /* DMA_DMA_H_ */
