/**
 * \file IfxHspdm.c
 * \brief HSPDM  basic functionality
 *
 * \version iLLD_1_0_1_17_0_1
 * \copyright Copyright (c) 2018 Infineon Technologies AG. All rights reserved.
 *
 *
 *                                 IMPORTANT NOTICE
 *
 * Use of this file is subject to the terms of use agreed between (i) you or
 * the company in which ordinary course of business you are acting and (ii)
 * Infineon Technologies AG or its licensees. If and as long as no such terms
 * of use are agreed, use of this file is subject to following:
 *
 * Boost Software License - Version 1.0 - August 17th, 2003
 *
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 *
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer, must
 * be included in all copies of the Software, in whole or in part, and all
 * derivative works of the Software, unless such copies or derivative works are
 * solely in the form of machine-executable object code generated by a source
 * language processor.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 *
 */

/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/

#include "IfxHspdm.h"

/******************************************************************************/
/*-------------------------Function Implementations---------------------------*/
/******************************************************************************/

void IfxHspdm_setStartAddress(Ifx_HSPDM *hspdm, IfxHspdm_Buffer buffer, uint32 address)
{
    if (address < IFXHSPDM_BUFFER_MAX_SIZE)
    {
        switch (buffer)
        {
        case IfxHspdm_Buffer_a:
            hspdm->BUFA0.B.STARTA = address;
            break;
        case IfxHspdm_Buffer_b:
            hspdm->BUFB0.B.STARTB = address;
            break;
        default:
            break;
        }
    }
    else
    {
        /* do nothin */
    }
}


void IfxHspdm_setEndAddress(Ifx_HSPDM *hspdm, IfxHspdm_Buffer buffer, uint32 address)
{
    if (address < IFXHSPDM_BUFFER_MAX_SIZE)
    {
        switch (buffer)
        {
        case IfxHspdm_Buffer_a:
            hspdm->BUFA0.B.ENDA = address;
            break;
        case IfxHspdm_Buffer_b:
            hspdm->BUFB0.B.ENDB = address;
            break;
        default:
            break;
        }
    }
    else
    {
        /* do nothin */
    }
}


void IfxHspdm_setMuteAddresses(Ifx_HSPDM *hspdm, IfxHspdm_MuteRange muteRange, uint32 startAddress, uint32 endAddress)
{
    switch (muteRange)
    {
    case IfxHspdm_MuteRange_0:
        hspdm->MUTE0.B.START0 = startAddress;
        hspdm->MUTE0.B.END0   = endAddress;
        break;
    case IfxHspdm_MuteRange_1:
        hspdm->MUTE1.B.START1 = startAddress;
        hspdm->MUTE1.B.END1   = endAddress;
        break;
    default:
        /* do nothing */
        break;
    }
}


void IfxHspdm_enableBSB(Ifx_HSPDM *hspdm, IfxHspdm_BSB bsb, boolean enable)
{
    switch (bsb)
    {
    case IfxHspdm_BSB_0:
        hspdm->CON.B.EN0 = (uint32)enable;
        break;
    case IfxHspdm_BSB_1:
        hspdm->CON.B.EN1 = (uint32)enable;
        break;
    default:
        break; /* do nothing here */
    }
}


void IfxHspdm_initBsPin(IfxHspdm_Bs_Out *bsPin, IfxPort_OutputMode outputMode, IfxPort_PadDriver padDriver)
{
    IfxPort_setPinModeOutput(bsPin->pin.port, bsPin->pin.pinIndex, outputMode, bsPin->select);
    IfxPort_setPinPadDriver(bsPin->pin.port, bsPin->pin.pinIndex, padDriver);
}


void IfxHspdm_initMutePin(IfxHspdm_Mute_Out *mutePin, IfxPort_OutputMode outputMode, IfxPort_PadDriver padDriver)
{
    IfxPort_setPinModeOutput(mutePin->pin.port, mutePin->pin.pinIndex, outputMode, mutePin->select);
    IfxPort_setPinPadDriver(mutePin->pin.port, mutePin->pin.pinIndex, padDriver);
}
