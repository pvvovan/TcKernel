	.section .inttab0, "ax", @progbits
	.balign 256 /* Ensure 256-byte boundary for BTV */
	.global __interrupt_table_0
	.type __trap_table_0, @function

	.balign 32
__interrupt_vector_0: /* Vector 0: Priority 0 (Ignored by TriCore hardware) */
	0: loopu 0b

	.balign 32
__interrupt_vector_1:
	svlcx
	movh.a	%a14, hi:vPortSystemContextHandler
	lea	%a14, [%a14] lo:vPortSystemContextHandler
	ji	%a14

	.balign 32
__interrupt_vector_2:
	svlcx
	movh.a	%a14, hi:vPortSystemTickHandler
	lea	%a14, [%a14] lo:vPortSystemTickHandler
	ji	%a14

	.balign 32
__interrupt_vector_3:
	3: loopu 3b

	.balign 32
__interrupt_vector_4:
	4: loopu 4b

	.balign 32
__interrupt_vector_5:
	5: loopu 5b
