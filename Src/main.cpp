#include "FreeRTOS.h"
#include "task.h"

__attribute__((section(".zdata"))) volatile int myvar = 1;
__attribute__((section(".zbss"))) volatile int myzero;
__attribute__((section(".zrodata"))) volatile int const ddx = 2;

__attribute__((section(".sdata"))) volatile long A0example = 20;
__attribute__((section(".sbss"))) volatile long A0example2;

long getval()
{
	volatile long v = 1;
	volatile long *p = &v;
	*p += 1;
	*p += 2;
	A0example += 16;
	return *p + A0example;
}

volatile int myval = getval();

void task_1(void *arg)
{
	(void)arg;
	TickType_t lastWakeTime = xTaskGetTickCount();
	const TickType_t period = pdMS_TO_TICKS(1000);
	for ( ; ; ) {
		xTaskDelayUntil(&lastWakeTime, period);
		A0example2 = getval();
	}
}

void task_2(void *arg)
{
	(void)arg;
	vTaskDelay(pdMS_TO_TICKS(500));
	TickType_t lastWakeTime = xTaskGetTickCount();
	const TickType_t period = pdMS_TO_TICKS(1000);
	for ( ; ; ) {
		xTaskDelayUntil(&lastWakeTime, period);
		myzero += 1;
	}
}

extern "C" int core0_main();

int core0_main()
{
	for ( ; ; ) {
		myvar += ddx;
		myval += myvar + getval();
		A0example2 += 1;
		myzero += 1;
		break;
	}
	xTaskCreate(task_1, "APP TASK 1", configMINIMAL_STACK_SIZE, NULL, 0, NULL);
	xTaskCreate(task_2, "APP TASK 2", configMINIMAL_STACK_SIZE, NULL, 0, NULL);
	vTaskStartScheduler();
	return 0;
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName)
{
	(void)xTask;
	(void)pcTaskName;
	for ( ; ; ) { }
}
