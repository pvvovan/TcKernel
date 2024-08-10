#ifndef RTOS_SRC_H_
#define RTOS_SRC_H_

#include <stdint.h>
#include <Stm.h>


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
template<uint16_t device_offset>
class SRC
{
    private:
        static constexpr uint32_t BASE {0xF0038000uL};
        static_assert(device_offset <= 0x00FD0u, "Service Request Control Register is out of range");


    public:
        virtual ~SRC() = default;

        SRC(uint32_t instance_offset)
            : R {*reinterpret_cast<Bits *>(BASE + device_offset + instance_offset)} { }

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

        volatile struct Bits &R;

        void EnableService(uint8_t prio, SRC_TOS tos) {
            this->R.CLRR = 1; /* Clear Service Request */
            this->R.SRPN = prio;
            this->R.TOS = static_cast<uint8_t>(tos);
            this->R.SRE = 1; /* Enable Service Request */
        }
};

template<uint8_t x, enum ICR irq>
class SRC_STMxSRy final : public SRC<0x00300u>
{
    private:
        static_assert(x < 6, "STMx not available");

    public:
        SRC_STMxSRy() : SRC(x * 8 + static_cast<uint32_t>(irq) * 4) { }
};

#endif /* RTOS_SRC_H_ */
