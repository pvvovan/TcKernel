	.section .traptab0, "ax", @progbits
	.balign 256 /* Ensure 256-byte boundary for BTV */
	.global __trap_table_0
	.type __trap_table_0, @function

	.balign 32
__trap_vector_0: /* MMU Traps (Trap Class 0) */
	0: loopu 0b

	.balign 32
__trap_vector_1: /* Internal Protection Traps (Trap Class 1) */
	1: loopu 1b

	.balign 32
__trap_vector_2: /* Instruction Errors (Trap Class 2) */
	2: loopu 2b

	.balign 32
__trap_vector_3: /* Context Management (Trap Class 3) */
	3: loopu 3b

	.balign 32
__trap_vector_4: /* System Bus and Peripheral Errors (Trap Class 4) */
	4: loopu 4b

	.balign 32
__trap_vector_5: /* Assertion Traps (Trap Class 5) */
	5: loopu 5b

	.balign 32
__trap_vector_6: /* System Call (Trap Class 6) */
	svlcx
	mov %d4, %d15
	call vPortSyscallHandler
	rslcx
	rfe

	.balign 32
__trap_vector_7: /* Non-Maskable Interrupt (Trap Class 7) */
	7: loopu 7b
