# tric_asm_file_start
	.file	"Ifx_Cfg_Ssw.c"
	.file	"Ifx_Cfg_Ssw.c"
.section .text,"ax",@progbits
	.section	.text.Ifx_Ssw_Pms_Init,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_Pms_Init
	.type	Ifx_Ssw_Pms_Init, @function
Ifx_Ssw_Pms_Init:
	mov.aa	%a14, %SP
	movh.a	%a2, 61443
	lea	%a2, [%a2] 24576
	ld.w	%d2, [%a2] 692
	extr.u	%d2, %d2, 2, 14
	movh.a	%a2, 61477
	lea	%a2, [%a2] -32724
	ld.w	%d3, [%a2]0
	jnz.t	%d3, 0, .L19
.L2:
#APP
	# 212 "C:\Users\elina\AURIX-v1.10.36-workspace-savetemps\tc375tp2\Libraries\Infra\Ssw\TC3xx\Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a11
	# 0 "" 2
#NO_APP
	ret	#Ifx_Ssw_Pms_Init
.L19:
	movh.a	%a2, hi:IfxPmsEvr_cfgSequenceDefault
	lea	%a3, [%a2] lo:IfxPmsEvr_cfgSequenceDefault
	ld.a	%a4, [%a3] 4
	ld.bu	%d6, [%a2] lo:IfxPmsEvr_cfgSequenceDefault
	mov.d	%d3, %a4
	madd	%d6, %d3, %d6, 12
	jge.u	%d3, %d6, .L2
	xor	%d2, %d2, 63
	sh	%d2, 2
	movh	%d1, 65532
	or	%d1, %d2
	movh	%d0, 65532
	add	%d0, 2
	or	%d0, %d2
	mov	%d8, 1
	movh.a	%a3, 61443
	lea	%a3, [%a3] 24576
	mov	%d4, %d8
	movh.a	%a5, 61477
	lea	%a5, [%a5] -32504
	movh	%d7, 19452
	addi	%d7, %d7, -15072
	lea	%a6, -268431344
	mov	%d9, 0
.L11:
	st.w	[%a3] 692, %d1
.L3:
	ld.w	%d2, [%a3] 692
	extr.u	%d2, %d2, 1, 1
	jeq	%d2, %d4, .L3
	ld.w	%d3, [%a4] 4
	ld.bu	%d2, [%a4]0
	madd	%d2, %d3, %d2, 12
	jge.u	%d3, %d2, .L4
	mov.a	%a2, %d3
.L5:
	ld.a	%a7, [%a2]0
	ld.w	%d2, [%a7]0
	ld.w	%d5, [%a2] 8
	andn	%d2, %d2, %d5
	ld.w	%d5, [%a2] 4
	or	%d2, %d5
	st.w	[%a7]0, %d2
	lea	%a2, [%a2] 12
	ld.bu	%d2, [%a4]0
	madd	%d2, %d3, %d2, 12
	mov.d	%d5, %a2
	jlt.u	%d5, %d2, .L5
.L4:
	ld.w	%d2, [%a5]0
	insert	%d2, %d2, 1, 30, 1
	st.w	[%a5]0, %d2
	st.w	[%a3] 692, %d0
.L6:
	ld.w	%d2, [%a3] 692
	jz.t	%d2, 1, .L6
	ld.w	%d2, [%a4] 8
	mul.f	%d2, %d7, %d2
	ftouz	%d3, %d2
	ld.w	%d5, [%a6]0
.L7:
	ld.w	%d2, [%a6]0
	sub	%d2, %d5
	jlt.u	%d2, %d3, .L7
	mov	%d2, 255
	j	.L8
.L10:
	add	%d2, -1
	jz	%d2, .L12
.L8:
	ld.w	%d3, [%a5]0
	extr.u	%d3, %d3, 30, 1
	jeq	%d3, %d4, .L10
	lea	%a4, [%a4] 12
	mov.d	%d2, %a4
	jlt.u	%d2, %d6, .L11
.L20:
	jnz	%d8, .L2
#APP
	# 1427 "C:\Users\elina\AURIX-v1.10.36-workspace-savetemps\tc375tp2\Libraries\iLLD\TC3xx\Tricore/Cpu/Std/IfxCpu_IntrinsicsGcc.h" 1
	debug
	# 0 "" 2
	# 212 "C:\Users\elina\AURIX-v1.10.36-workspace-savetemps\tc375tp2\Libraries\Infra\Ssw\TC3xx\Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a11
	# 0 "" 2
#NO_APP
	ret	#Ifx_Ssw_Pms_Init
.L12:
	mov	%d8, %d9
	lea	%a4, [%a4] 12
	mov.d	%d2, %a4
	jlt.u	%d2, %d6, .L11
	j	.L20
	.size Ifx_Ssw_Pms_Init, .-Ifx_Ssw_Pms_Init
	.global	Ifx_Ssw_Pms_Init_end
Ifx_Ssw_Pms_Init_end:
	.section	.text.Ifx_Ssw_Pms_InitCheck,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_Pms_InitCheck
	.type	Ifx_Ssw_Pms_InitCheck, @function
Ifx_Ssw_Pms_InitCheck:
	mov.aa	%a14, %SP
	movh.a	%a2, 61477
	lea	%a2, [%a2] -32724
	ld.w	%d2, [%a2]0
	jnz.t	%d2, 0, .L28
.L22:
#APP
	# 212 "C:\Users\elina\AURIX-v1.10.36-workspace-savetemps\tc375tp2\Libraries\Infra\Ssw\TC3xx\Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a11
	# 0 "" 2
#NO_APP
	ret	#Ifx_Ssw_Pms_InitCheck
.L28:
	movh.a	%a2, hi:IfxPmsEvr_checkRegCfgDefault
	ld.bu	%d5, [%a2] lo:IfxPmsEvr_checkRegCfgDefault
	jlez	%d5, .L23
	movh.a	%a2, hi:IfxPmsEvr_checkRegCfgDefault+4
	ld.a	%a2, [%a2] lo:IfxPmsEvr_checkRegCfgDefault+4
	mov	%d2, 1
	mov	%d3, 0
.L25:
	ld.a	%a3, [%a2]0
	ld.w	%d4, [%a3]0
	ld.w	%d6, [%a2] 8
	and	%d4, %d6
	ld.w	%d6, [%a2] 4
	eq	%d4, %d4, %d6
	sel	%d2, %d4, %d2, 0
	add	%d3, 1
	lea	%a2, [%a2] 12
	jne	%d3, %d5, .L25
	jeq	%d2, 1, .L23
#APP
	# 1427 "C:\Users\elina\AURIX-v1.10.36-workspace-savetemps\tc375tp2\Libraries\iLLD\TC3xx\Tricore/Cpu/Std/IfxCpu_IntrinsicsGcc.h" 1
	debug
	# 0 "" 2
#NO_APP
.L29:
#APP
	# 212 "C:\Users\elina\AURIX-v1.10.36-workspace-savetemps\tc375tp2\Libraries\Infra\Ssw\TC3xx\Tricore/Ifx_Ssw_CompilersGcc.h" 1
	ji %a11
	# 0 "" 2
#NO_APP
	ret	#Ifx_Ssw_Pms_InitCheck
.L23:
	movh.a	%a2, 61477
	lea	%a2, [%a2] -32724
	ld.w	%d2, [%a2]0
	jnz.t	%d2, 21, .L22
#APP
	# 1427 "C:\Users\elina\AURIX-v1.10.36-workspace-savetemps\tc375tp2\Libraries\iLLD\TC3xx\Tricore/Cpu/Std/IfxCpu_IntrinsicsGcc.h" 1
	debug
	# 0 "" 2
#NO_APP
	j	.L29
	.size Ifx_Ssw_Pms_InitCheck, .-Ifx_Ssw_Pms_InitCheck
	.global	Ifx_Ssw_Pms_InitCheck_end
Ifx_Ssw_Pms_InitCheck_end:
	.section	.text.hardware_init_hook,"ax",@progbits
	.align 1
	.global	hardware_init_hook
	.type	hardware_init_hook, @function
hardware_init_hook:
	mov.aa	%a14, %SP
	ret	#hardware_init_hook
	.size hardware_init_hook, .-hardware_init_hook
	.global	hardware_init_hook_end
hardware_init_hook_end:
	.section	.text.software_init_hook,"ax",@progbits
	.align 1
	.global	software_init_hook
	.type	software_init_hook, @function
software_init_hook:
	mov.aa	%a14, %SP
	ret	#software_init_hook
	.size software_init_hook, .-software_init_hook
	.global	software_init_hook_end
software_init_hook_end:
	.extern	IfxPmsEvr_checkRegCfgDefault,STT_OBJECT,8
	.extern	IfxPmsEvr_cfgSequenceDefault,STT_OBJECT,8
	.ident	"GCC: (AURIX(tm) GCC - Built 2026-03-19 10:32:43) 11.3.1 20221230"
.section .callinfo
  .word Ifx_Ssw_Pms_Init #name
  .word Ifx_Ssw_Pms_Init_end #sz
  .word 0x54fc03ff #reg
  .word 0x00000000 #arg
  .word 0x00000000 #ret
  .word 0x000001c0 #stat
  .word Ifx_Ssw_Pms_InitCheck #name
  .word Ifx_Ssw_Pms_InitCheck_end #sz
  .word 0x440c007c #reg
  .word 0x00000000 #arg
  .word 0x00000000 #ret
  .word 0x000001c0 #stat
  .word hardware_init_hook #name
  .word hardware_init_hook_end #sz
  .word 0x44000000 #reg
  .word 0x00000000 #arg
  .word 0x00000000 #ret
  .word 0x000000c0 #stat
  .word software_init_hook #name
  .word software_init_hook_end #sz
  .word 0x44000000 #reg
  .word 0x00000000 #arg
  .word 0x00000000 #ret
  .word 0x000000e0 #stat
