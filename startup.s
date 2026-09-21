	.section .startup, "ax"
	.global _START
	.type _START, @function
_START:
	/* Initialize Program Status Word (PSW) */
	movh	%d0, 0x0000
	mov	%d0, 0x0980	/* Enable supervisor mode, disable interrupts */
	mtcr	$PSW, %d0	/* Move to Core Register (PSW) */
	isync			/* Instruction synchronization pipeline flush */

	movh.a	%a14, hi:main
	lea	%a14, [%a14]lo:main
	ji	%a14		/* Jump to main app */

	disable
	isync
.L_stall_loop:
	j	.L_stall_loop
