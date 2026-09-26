# tric_asm_file_start
	.file	"Ifx_Ssw_Tc0.c"
	.file	"Ifx_Ssw_Tc0.c"
.section .text,"ax",@progbits
	.section	.text.__StartUpSoftware_Phase2,"ax",@progbits
	.align 1
	.type	__StartUpSoftware_Phase2, @function
__StartUpSoftware_Phase2:
	movh.a	%a2, hi:Ifx_Ssw_Pms_Init
	lea	%a2, [%a2] lo:Ifx_Ssw_Pms_Init
#APP
	# 206 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	jli %a2
	# 0 "" 2
#NO_APP
	movh.a	%a2, hi:Ifx_Ssw_Pms_InitCheck
	lea	%a2, [%a2] lo:Ifx_Ssw_Pms_InitCheck
#APP
	# 206 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	jli %a2
	# 0 "" 2
#NO_APP
	movh.a	%a2, hi:__StartUpSoftware_Phase3PowerOnResetPath
	lea	%a2, [%a2] lo:__StartUpSoftware_Phase3PowerOnResetPath
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware_Phase2
	.size __StartUpSoftware_Phase2, .-__StartUpSoftware_Phase2
	.section	.text.__StartUpSoftware_Phase3PowerOnResetPath,"ax",@progbits
	.align 1
	.type	__StartUpSoftware_Phase3PowerOnResetPath, @function
__StartUpSoftware_Phase3PowerOnResetPath:
	movh.a	%a3, hi:__CSA0
	movh.a	%a2, hi:__CSA0_END
	lea	%a3, [%a3] lo:__CSA0
	lea	%a2, [%a2] lo:__CSA0_END
	sub.a	%a2, %a2, %a3
	mov.d	%d2, %a2
	sh	%d6, %d2, -6
	jz	%d6, .L4
	mov.d	%d2, %a3
	extr.u	%d4, %d2, 6, 16
	movh	%d7, 15
	sh	%d5, %d2, -12
	and	%d5, %d7
	mov	%d3, 0
	addi	%d0, %d6, -3
	mov.a	%a2, 0
	or	%d4, %d5
	jz	%d3, .L11
.L5:
	st.w	[%a2]0, %d4
	jeq	%d3, %d0, .L12
.L7:
	add	%d3, 1
	mov.a	%a2, %d2
	addi	%d4, %d2, 64
	jeq	%d6, %d3, .L13
.L9:
	mov	%d2, %d4
	extr.u	%d4, %d2, 6, 16
	sh	%d5, %d2, -12
	and	%d5, %d7
	or	%d4, %d5
	jnz	%d3, .L5
.L11:
#APP
	# 636 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.h" 1
	mtcr LO:0xFE38, %d4
	# 0 "" 2
#NO_APP
	jne	%d3, %d0, .L7
.L12:
#APP
	# 645 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.h" 1
	mtcr LO:0xFE3C, %d4
	# 0 "" 2
#NO_APP
	add	%d3, 1
	mov.a	%a2, %d2
	addi	%d4, %d2, 64
	jne	%d6, %d3, .L9
.L13:
	addi	%d2, %d6, -1
	sh	%d2, 6
	addsc.a	%a3, %a3, %d2, 0
	mov	%d2, 0
	st.w	[%a3]0, %d2
#APP
	# 159 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	dsync
	# 0 "" 2
	# 165 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	isync
	# 0 "" 2
#NO_APP
	movh.a	%a2, hi:__StartUpSoftware_Phase4
	lea	%a2, [%a2] lo:__StartUpSoftware_Phase4
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware_Phase3PowerOnResetPath
.L4:
	st.w	0x00000000, %d6
	call	abort
	.size __StartUpSoftware_Phase3PowerOnResetPath, .-__StartUpSoftware_Phase3PowerOnResetPath
	.section	.text.__StartUpSoftware_Phase3ApplicationResetPath,"ax",@progbits
	.align 1
	.type	__StartUpSoftware_Phase3ApplicationResetPath, @function
__StartUpSoftware_Phase3ApplicationResetPath:
	movh.a	%a3, hi:__CSA0
	movh.a	%a2, hi:__CSA0_END
	lea	%a3, [%a3] lo:__CSA0
	lea	%a2, [%a2] lo:__CSA0_END
	sub.a	%a2, %a2, %a3
	mov.d	%d2, %a2
	sh	%d6, %d2, -6
	jz	%d6, .L15
	mov.d	%d2, %a3
	extr.u	%d4, %d2, 6, 16
	movh	%d7, 15
	sh	%d5, %d2, -12
	and	%d5, %d7
	mov	%d3, 0
	addi	%d0, %d6, -3
	mov.a	%a2, 0
	or	%d4, %d5
	jz	%d3, .L22
.L16:
	st.w	[%a2]0, %d4
	jeq	%d3, %d0, .L23
.L18:
	add	%d3, 1
	mov.a	%a2, %d2
	addi	%d4, %d2, 64
	jeq	%d6, %d3, .L24
.L20:
	mov	%d2, %d4
	extr.u	%d4, %d2, 6, 16
	sh	%d5, %d2, -12
	and	%d5, %d7
	or	%d4, %d5
	jnz	%d3, .L16
.L22:
#APP
	# 636 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.h" 1
	mtcr LO:0xFE38, %d4
	# 0 "" 2
#NO_APP
	jne	%d3, %d0, .L18
.L23:
#APP
	# 645 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.h" 1
	mtcr LO:0xFE3C, %d4
	# 0 "" 2
#NO_APP
	add	%d3, 1
	mov.a	%a2, %d2
	addi	%d4, %d2, 64
	jne	%d6, %d3, .L20
.L24:
	addi	%d2, %d6, -1
	sh	%d2, 6
	addsc.a	%a3, %a3, %d2, 0
	mov	%d2, 0
	st.w	[%a3]0, %d2
#APP
	# 159 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	dsync
	# 0 "" 2
	# 165 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	isync
	# 0 "" 2
#NO_APP
	movh.a	%a2, hi:__StartUpSoftware_Phase5
	lea	%a2, [%a2] lo:__StartUpSoftware_Phase5
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware_Phase3ApplicationResetPath
.L15:
	st.w	0x00000000, %d6
	call	abort
	.size __StartUpSoftware_Phase3ApplicationResetPath, .-__StartUpSoftware_Phase3ApplicationResetPath
	.section	.text.__StartUpSoftware_Phase6,"ax",@progbits
	.align 1
	.type	__StartUpSoftware_Phase6, @function
__StartUpSoftware_Phase6:
	movh.a	%a2, hi:__Core0_start
	lea	%a2, [%a2] lo:__Core0_start
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware_Phase6
	.size __StartUpSoftware_Phase6, .-__StartUpSoftware_Phase6
	.section	.text.__StartUpSoftware_Phase4,"ax",@progbits
	.align 1
	.type	__StartUpSoftware_Phase4, @function
__StartUpSoftware_Phase4:
	movh.a	%a4, 61443
	ld.w	%d4, [%a4] 25164
	movh.a	%a2, 61443
	ld.w	%d8, [%a2] 25256
	extr.u	%d4, %d4, 2, 14
	lea	%a4, [%a4] 25164
	lea	%a2, [%a2] 25256
	extr.u	%d8, %d8, 2, 14
	xor	%d4, %d4, 63
	call	Ifx_Ssw_serviceCpuWatchdog
	xor	%d4, %d8, 63
	call	Ifx_Ssw_serviceSafetyWatchdog
	movh.a	%a2, hi:__StartUpSoftware_Phase5
	lea	%a2, [%a2] lo:__StartUpSoftware_Phase5
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware_Phase4
	.size __StartUpSoftware_Phase4, .-__StartUpSoftware_Phase4
	.section	.text.__StartUpSoftware_Phase5,"ax",@progbits
	.align 1
	.type	__StartUpSoftware_Phase5, @function
__StartUpSoftware_Phase5:
	movh.a	%a12, 61443
	ld.w	%d2, [%a12] 25164
	movh.a	%a2, 61443
	extr.u	%d2, %d2, 2, 14
	ld.w	%d9, [%a2] 25256
	xor	%d8, %d2, 63
	lea	%a12, [%a12] 25164
	extr.u	%d9, %d9, 2, 14
	lea	%a2, [%a2] 25256
	mov.aa	%a4, %a12
	mov	%d4, %d8
	call	Ifx_Ssw_disableCpuWatchdog
	xor	%d9, %d9, 63
	mov	%d4, %d9
	call	Ifx_Ssw_disableSafetyWatchdog
	call	Ifx_Ssw_doCppInit
	mov	%d4, %d9
	call	Ifx_Ssw_enableSafetyWatchdog
	mov	%d4, %d8
	mov.aa	%a4, %a12
	call	Ifx_Ssw_enableCpuWatchdog
	movh.a	%a2, hi:__StartUpSoftware_Phase6
	lea	%a2, [%a2] lo:__StartUpSoftware_Phase6
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware_Phase5
	.size __StartUpSoftware_Phase5, .-__StartUpSoftware_Phase5
	.section	.text.__Core0_start,"ax",@progbits
	.align 1
	.type	__Core0_start, @function
__Core0_start:
	movh.a	%a2, 61443
	movh.a	%a3, 61443
	ld.w	%d3, [%a2] 25164
	ld.w	%d2, [%a3] 25256
	extr.u	%d3, %d3, 2, 14
	extr.u	%d2, %d2, 2, 14
	ld.w	%d4, [%a2] 25164
	xor	%d8, %d3, 63
	lea	%a2, [%a2] 25164
	lea	%a3, [%a3] 25256
	xor	%d9, %d2, 63
	sh	%d2, %d8, 2
	jz.t	%d4, 1, .L30
	ld.w	%d3, [%a2]0
	sh	%d2, %d8, 2
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a2]0, %d3
.L30:
	movh.a	%a2, 61443
	ld.w	%d4, [%a2] 25164
	lea	%a2, [%a2] 25164
	insert	%d4, %d4, 0, 0, 16
	mov	%d3, 0
	or	%d4, %d2
	or	%d4, %d4, 2
	st.w	[%a2]0, %d4
	ld.w	%d4, [%a2]0
#APP
	# 305 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	mtcr LO:0x920C, %d3
	# 0 "" 2
	# 165 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	isync
	# 0 "" 2
	# 313 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	mtcr LO:0x9040, %d3
	# 0 "" 2
	# 165 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	isync
	# 0 "" 2
#NO_APP
	movh.a	%a3, hi:__TRAPTAB_CPU0
	mov.d	%d3, %a3
	addi	%d3, %d3, lo:__TRAPTAB_CPU0
#APP
	# 318 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	mtcr LO:0xFE24, %d3
	# 0 "" 2
#NO_APP
	movh.a	%a3, hi:__INTTAB_CPU0
	mov.d	%d3, %a3
	addi	%d3, %d3, lo:__INTTAB_CPU0
#APP
	# 320 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	mtcr LO:0xFE20, %d3
	# 0 "" 2
#NO_APP
	movh.a	%a3, hi:__ISTACK0
	mov.d	%d3, %a3
	addi	%d3, %d3, lo:__ISTACK0
#APP
	# 322 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	mtcr LO:0xFE28, %d3
	# 0 "" 2
#NO_APP
	ld.w	%d3, [%a2]0
	jz.t	%d3, 1, .L31
	ld.w	%d3, [%a2]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a2]0, %d3
.L31:
	movh.a	%a12, 61443
	ld.w	%d3, [%a12] 25164
	lea	%a12, [%a12] 25164
	insert	%d3, %d3, 0, 0, 16
	mov.aa	%a4, %a12
	or	%d2, %d3
	or	%d2, %d2, 3
	mov	%d4, %d8
	st.w	[%a12]0, %d2
	ld.w	%d2, [%a12]0
	call	Ifx_Ssw_disableCpuWatchdog
	mov	%d4, %d9
	call	Ifx_Ssw_disableSafetyWatchdog
	call	hardware_init_hook
	call	software_init_hook
	mov	%d4, %d9
	call	Ifx_Ssw_enableSafetyWatchdog
	mov	%d4, %d8
	mov.aa	%a4, %a12
	call	Ifx_Ssw_enableCpuWatchdog
	movh.a	%a2, hi:main
	lea	%a2, [%a2] lo:main
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
	# 217 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	1: loopu	 1b
	# 0 "" 2
#NO_APP
	ret	#__Core0_start
	.size __Core0_start, .-__Core0_start
	.section	.text.__StartUpSoftware,"ax",@progbits
	.align 1
	.type	__StartUpSoftware, @function
__StartUpSoftware:
#APP
	# 139 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	movh.a	 %a1, hi:(__A1_MEM)
	lea	 %a1,[%a1] lo:(__A1_MEM)
	# 0 "" 2
	# 141 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	movh.a	 %a0, hi:(__A0_MEM)
	lea	 %a0,[%a0] lo:(__A0_MEM)
	# 0 "" 2
	# 144 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	movh.a	 %a8, hi:(__A8_MEM)
	lea	 %a8,[%a8] lo:(__A8_MEM)
	# 0 "" 2
	# 145 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	movh.a	 %a9, hi:(__A9_MEM)
	lea	 %a9,[%a9] lo:(__A9_MEM)
	# 0 "" 2
#NO_APP
	mov	%d2, 2432
#APP
	# 148 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	mtcr LO:0xFE04, %d2
	# 0 "" 2
#NO_APP
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 24656
	movh	%d3, 5005
	and	%d3, %d2
	lea	%a2, [%a2] 24656
	jnz	%d3, .L36
	and	%d3, %d2, 251
	jz	%d3, .L37
	movh.a	%a2, 61443
	clz	%d2, %d3
	rsub	%d2, %d2, 31
	ld.w	%d3, [%a2] 24664
	sh	%d2, 1
	extr.u	%d2, %d3, %d2, 2
	lea	%a2, [%a2] 24664
	jeq	%d2, 2, .L38
.L36:
	movh.a	%a2, hi:__StartUpSoftware_Phase2
	lea	%a2, [%a2] lo:__StartUpSoftware_Phase2
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware
.L37:
	jz.t	%d2, 20, .L43
.L38:
	movh.a	%a2, hi:__StartUpSoftware_Phase3ApplicationResetPath
	lea	%a2, [%a2] lo:__StartUpSoftware_Phase3ApplicationResetPath
#APP
	# 200 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a2
	# 0 "" 2
#NO_APP
	ret	#__StartUpSoftware
.L43:
	movh.a	%a2, 63617
	ld.w	%d2, [%a2] -12288
	lea	%a2, [%a2] -12288
	extr.u	%d2, %d2, 1, 2
	jnz	%d2, .L38
	j	.L36
	.size __StartUpSoftware, .-__StartUpSoftware
	.section	.start,"ax",@progbits
	.align 1
	.global	_START
	.type	_START, @function
_START:
#APP
	# 390 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Tc0.c" 1
	movh.a %a10, hi:(__USTACK0)
	lea %a10, [%a10]lo:(__USTACK0)
 	dsync 
	movh.a %a15,  hi:(__StartUpSoftware)
	lea %a15, [%a15]lo:(__StartUpSoftware)
	ji %a15
	# 0 "" 2
#NO_APP
	ret	#_START
	.size _START, .-_START
	.global	_START_end
_START_end:
	.extern	main,STT_FUNC,0
	.extern	software_init_hook,STT_FUNC,0
	.extern	hardware_init_hook,STT_FUNC,0
	.extern	__ISTACK0,STT_OBJECT,-1
	.extern	__INTTAB_CPU0,STT_OBJECT,-1
	.extern	__TRAPTAB_CPU0,STT_OBJECT,-1
	.extern	Ifx_Ssw_enableCpuWatchdog,STT_FUNC,0
	.extern	Ifx_Ssw_enableSafetyWatchdog,STT_FUNC,0
	.extern	Ifx_Ssw_doCppInit,STT_FUNC,0
	.extern	Ifx_Ssw_disableSafetyWatchdog,STT_FUNC,0
	.extern	Ifx_Ssw_disableCpuWatchdog,STT_FUNC,0
	.extern	Ifx_Ssw_serviceSafetyWatchdog,STT_FUNC,0
	.extern	Ifx_Ssw_serviceCpuWatchdog,STT_FUNC,0
	.extern	abort,STT_FUNC,0
	.extern	__CSA0_END,STT_OBJECT,-1
	.extern	__CSA0,STT_OBJECT,-1
	.extern	Ifx_Ssw_Pms_InitCheck,STT_FUNC,0
	.extern	Ifx_Ssw_Pms_Init,STT_FUNC,0
	.ident	"GCC: (AURIX(tm) GCC - Built 2026-03-19 10:32:43) 11.3.1 20221230"
.section .callinfo
  .word _START #name
  .word _START_end #sz
  .word 0x00000000 #reg
  .word 0x00000000 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
