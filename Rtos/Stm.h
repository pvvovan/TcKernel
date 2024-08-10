#ifndef RTOS_STM_H_
#define RTOS_STM_H_

#include <stdint.h>
#include <type_traits>


enum class ICR { Irq_0 = 0, Irq_1 = 1 };

/* System Timer (STM) is designed for global system timing applications
 * requiring both high precision and long period. */
template<uint32_t core>
class STM final
{   
    private:
    static constexpr uint32_t STM_BASE {0xF0001000uL};
    static constexpr uint32_t STM_SIZE {0x100};
    static_assert(core < 6, "Core out of range");


    public:
    static constexpr uint32_t TICKS_1MS {100000};

    /* Registers TIM0 to TIM6 provide 32-bit views at varying resolutions of the underlying STM counter */
    template<uint32_t x>
    static volatile uint32_t& TIM() {
        static_assert(x < 7, "TIM register is not available");
        return *reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x10 + x * 4);
    }

    /* The compare register CMPx holds up to 32-bits; its value is compared to the value of the STM */
    template<uint32_t x>
    static volatile uint32_t& CMP() {
        static_assert(x < 2, "CMP register is not available");
        return *reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x30 + x * 4);
    }

    /* The STM Compare Match Control Register controls the parameters of the compare logic */
    volatile uint32_t& CMCON {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x38)};
    static constexpr uint32_t CMCON_MSIZE0 {0x1F}; /* 1FH CMP0[31:0] used for compare operation */
    static constexpr uint32_t CMCON_MSIZE1 {0x1FuL << 16}; /* 1FH CMP1[31:0] used for compare operation */

    /* The two compare match interrupts of the STM are controlled by the STM Interrupt Control Register */
    volatile uint32_t& ICR {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x3C)};
    static constexpr uint32_t ICR_CMP0EN {1uL << 0}; /* 1B Interrupt on compare match with CMP0 enabled */
    static constexpr uint32_t ICR_CMP1EN {1uL << 4}; /* 1B Interrupt on compare match with CMP1 enabled */
    static constexpr uint32_t ICR_CMP1OS {1uL << 6}; /* Compare Register CMP1 Interrupt Output Selection */

    /* The bits in the STM Interrupt Set/Clear Register make it possible to set or clear the
     * compare match interrupt request status flags of register ICR */
    volatile uint32_t& ISCR {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x40)};
    static constexpr uint32_t ISCR_CMP0IRR {1uL << 0}; /* 1B Bit ICR.CMP0IR is cleared */
    static constexpr uint32_t ISCR_CMP1IRR {1uL << 2}; /* 1B Bit ICR.CMP1IR is cleared */

    /* OCDS Control and Status Register */
    volatile uint32_t& OCS {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0xE8)};
    static constexpr uint32_t OCS_SUS   {2uL << 24}; /* 2H 64-bit counter will be stopped */
    static constexpr uint32_t OCS_SUS_P {1uL << 28}; /* SUS is only written when SUS_P is 1, otherwise unchanged. Read as 0 */

    void Enable(enum ICR irq) {
        switch (irq) {
            case ICR::Irq_0:
                this->CMP<0>() = this->TIM<0>() + TICKS_1MS;
                this->CMCON |= CMCON_MSIZE0; /* Compare Register Size for CMP0 */
                this->ICR |= ICR_CMP0EN; /* Enable interrupt on compare match with CMP0 */
                this->ISCR = ISCR_CMP0IRR; /* Reset Compare Register CMP0 Interrupt Flag */
                break;

            case ICR::Irq_1:
                this->CMP<1>() = this->TIM<0>() + TICKS_1MS;
                this->CMCON |= CMCON_MSIZE1; /* Compare Register Size for CMP0 */
                this->ICR |= ICR_CMP1EN | ICR_CMP1OS; /* Enable interrupt output STMIR1 on compare match with CMP1 */
                this->ISCR = ISCR_CMP1IRR; /* Reset Compare Register CMP0 Interrupt Flag */
                break;
        }
        this->OCS = OCS_SUS | OCS_SUS_P; /* OCDS Suspend Control */
    }

    void Isr(enum ICR irq) {
        if (irq == ICR::Irq_0) {
            this->ISCR = ISCR_CMP0IRR; /* Reset Compare Register CMP0 Interrupt Flag */
            this->CMP<0>() += TICKS_1MS;
        } else if (irq == ICR::Irq_1) {
            this->ISCR = ISCR_CMP1IRR; /* Reset Compare Register CMP1 Interrupt Flag */
            this->CMP<1>() += TICKS_1MS;
        } else {
            /* STM has only two interrupt outputs */
        }
    }
};

#endif /* RTOS_STM_H_ */
