/*
 * KernelCore0.h
 *
 *  Created on: Jul 28, 2024
 *      Author: pvvov
 */

#ifndef RTOS_KERNELCORE0_H_
#define RTOS_KERNELCORE0_H_

#ifdef __cplusplus
extern "C" {
#endif

void KernelCore0_Start(void);
void KernelCore0_SysIsr(void);

#ifdef __cplusplus
}
#endif

#endif /* RTOS_KERNELCORE0_H_ */
