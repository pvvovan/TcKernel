/*
 * Stm.h
 *
 *  Created on: Jul 28, 2024
 *      Author: pvvov
 */

#ifndef STM_STM_H_
#define STM_STM_H_

#include <stdint.h>
#include <type_traits>


/* System Timer (STM) is designed for global system timing applications
 * requiring both high precision and long period. */
template<uint32_t core>
class STM final
{   
    private:
    static const uint32_t STM_BASE {0xF0001000uL};
    static const uint32_t STM_SIZE {0x100};
    static_assert(core < 6, "Core out of range");


    public:
    static const uint32_t TICKS_1MS {100000};

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
    const uint32_t CMCON_MSIZE0 {0x1F}; /* 1FH CMP0[31:0] used for compare operation */

    /* The two compare match interrupts of the STM are controlled by the STM Interrupt Control Register */
    volatile uint32_t& ICR {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x3C)};
    const uint32_t ICR_CMP0EN {1uL << 0}; /* 1B Interrupt on compare match with CMP0 enabled */

    /* The bits in the STM Interrupt Set/Clear Register make it possible to set or clear the
     * compare match interrupt request status flags of register ICR */
    volatile uint32_t& ISCR {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0x40)};
    const uint32_t ISCR_CMP0IRR {1uL << 0}; /* 1B Bit ICR.CMP0IR is cleared */

    /* OCDS Control and Status Register */
    volatile uint32_t& OCS {*reinterpret_cast<uint32_t *>(STM_BASE + core * STM_SIZE + 0xE8)};
    const uint32_t OCS_SUS {2uL << 24}; /* 2H 64-bit counter will be stopped */

    void EnableSysIrq() {
        this->CMP<0>() = this->TIM<0>() + TICKS_1MS;
        this->CMCON = CMCON_MSIZE0; /* Compare Register Size for CMP0 */
        this->ICR = ICR_CMP0EN; /* Enable interrupt on compare match with CMP0 */
        this->OCS = OCS_SUS; /* OCDS Suspend Control */
        this->ISCR = ISCR_CMP0IRR; /* Reset Compare Register CMP0 Interrupt Flag */
    }

    void HandleIsr() {
        this->ISCR = ISCR_CMP0IRR; /* Reset Compare Register CMP0 Interrupt Flag */
        this->CMP<0>() += TICKS_1MS;
    }
};

#endif /* STM_STM_H_ */
