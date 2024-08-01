#ifndef RTOS_SRC_H_
#define RTOS_SRC_H_

#include <stdint.h>


enum class SRC_TOS {
    CPU0 = 0,
    DMA  = 1,
    CPU1 = 2,
    CPU2 = 3,
    CPU3 = 4,
    CPU4 = 5,
    CPU5 = 6
};

/* Service Request Control Register */
template<uint16_t offset>
class SRC
{
    private:
        const uint32_t BASE {0xF0038000uL};
        static_assert(offset <= 0x00FD0u, "Service Request Control Register is out of range");


    public:
        SRC() = default;
        virtual ~SRC() = default;

        SRC(uint32_t instance) : Reg {*reinterpret_cast<Bits *>(BASE + offset + instance)} { }

        struct Bits {
            uint8_t SRPN    : 8; /* Service Request Priority Number */
            uint8_t         : 2; /* Reserved */
            uint8_t SRE     : 1; /* Service Request Enable */
            uint8_t TOS     : 3; /* Type of Service Control */
            uint8_t         : 2; /* Reserved */
            uint8_t ECC     : 5; /* Error Correction Code */
            uint8_t         : 3; /* Reserved */
            uint8_t SRR     : 1; /* Service Request Flag */
            uint8_t CLRR    : 1; /* Request Clear Bit */
            uint8_t SETR    : 1; /* Request Set Bit */
            uint8_t IOV     : 1; /* Interrupt Trigger Overflow Bit */
            uint8_t IOVCLR  : 1; /* Interrupt Trigger Overflow Clear Bit */
            uint8_t SWS     : 1; /* SW Sticky Bit */
            uint8_t SWSCLR  : 1; /* SW Sticky Clear Bit */
            uint8_t         : 1; /* Reserved */
        };

        volatile struct Bits &Reg {*reinterpret_cast<Bits *>(BASE + offset)};

        void EnableService(uint8_t prio, SRC_TOS tos) {
            this->Reg.CLRR = 1; /* Clear Service Request */
            this->Reg.SRPN = prio;
            this->Reg.TOS = static_cast<uint8_t>(tos);
            this->Reg.SRE = 1; /* Enable Service Request */
        }
};

template<uint8_t x, uint8_t y>
class SRC_STMxSRy final : public SRC<0x00300u>
{
    private:
        static_assert(x < 6, "STMx not available");
        static_assert(y < 2, "STM SRy not available");

    public:
        SRC_STMxSRy() : SRC(x * 8 + y * 4) { }
};

#endif /* RTOS_SRC_H_ */
