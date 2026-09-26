# tric_asm_file_start
	.file	"Ifx_Ssw_Infra.c"
	.file	"Ifx_Ssw_Infra.c"
.section .text,"ax",@progbits
	.section	.text.Ifx_Ssw_getCpuWatchdogPassword,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_getCpuWatchdogPassword
	.type	Ifx_Ssw_getCpuWatchdogPassword, @function
Ifx_Ssw_getCpuWatchdogPassword:
	ld.w	%d2, [%a4]0
	extr.u	%d2, %d2, 2, 14
	xor	%d2, %d2, 63
	ret	#Ifx_Ssw_getCpuWatchdogPassword
	.size Ifx_Ssw_getCpuWatchdogPassword, .-Ifx_Ssw_getCpuWatchdogPassword
	.global	Ifx_Ssw_getCpuWatchdogPassword_end
Ifx_Ssw_getCpuWatchdogPassword_end:
	.section	.text.Ifx_Ssw_getSafetyWatchdogPassword,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_getSafetyWatchdogPassword
	.type	Ifx_Ssw_getSafetyWatchdogPassword, @function
Ifx_Ssw_getSafetyWatchdogPassword:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 25256
	lea	%a2, [%a2] 25256
	extr.u	%d2, %d2, 2, 14
	xor	%d2, %d2, 63
	ret	#Ifx_Ssw_getSafetyWatchdogPassword
	.size Ifx_Ssw_getSafetyWatchdogPassword, .-Ifx_Ssw_getSafetyWatchdogPassword
	.global	Ifx_Ssw_getSafetyWatchdogPassword_end
Ifx_Ssw_getSafetyWatchdogPassword_end:
	.section	.text.Ifx_Ssw_clearCpuEndinit,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_clearCpuEndinit
	.type	Ifx_Ssw_clearCpuEndinit, @function
Ifx_Ssw_clearCpuEndinit:
	extr.u	%d2, %d4, 0, 16
	ld.w	%d3, [%a4]0
	sh	%d2, 2
	jz.t	%d3, 1, .L5
	ld.w	%d3, [%a4]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a4]0, %d3
.L5:
	ld.w	%d3, [%a4]0
	insert	%d3, %d3, 0, 0, 16
	or	%d2, %d3
	or	%d2, %d2, 2
	st.w	[%a4]0, %d2
	ld.w	%d2, [%a4]0
	ret	#Ifx_Ssw_clearCpuEndinit
	.size Ifx_Ssw_clearCpuEndinit, .-Ifx_Ssw_clearCpuEndinit
	.global	Ifx_Ssw_clearCpuEndinit_end
Ifx_Ssw_clearCpuEndinit_end:
	.section	.text.Ifx_Ssw_setCpuEndinit,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_setCpuEndinit
	.type	Ifx_Ssw_setCpuEndinit, @function
Ifx_Ssw_setCpuEndinit:
	extr.u	%d2, %d4, 0, 16
	ld.w	%d3, [%a4]0
	sh	%d2, 2
	jz.t	%d3, 1, .L10
	ld.w	%d3, [%a4]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a4]0, %d3
.L10:
	ld.w	%d3, [%a4]0
	insert	%d3, %d3, 0, 0, 16
	or	%d2, %d3
	or	%d2, %d2, 3
	st.w	[%a4]0, %d2
	ld.w	%d2, [%a4]0
	ret	#Ifx_Ssw_setCpuEndinit
	.size Ifx_Ssw_setCpuEndinit, .-Ifx_Ssw_setCpuEndinit
	.global	Ifx_Ssw_setCpuEndinit_end
Ifx_Ssw_setCpuEndinit_end:
	.section	.text.Ifx_Ssw_clearSafetyEndinit,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_clearSafetyEndinit
	.type	Ifx_Ssw_clearSafetyEndinit, @function
Ifx_Ssw_clearSafetyEndinit:
	movh.a	%a2, 61443
	extr.u	%d2, %d4, 0, 16
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	sh	%d2, 2
	jz.t	%d3, 1, .L15
	ld.w	%d3, [%a2]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a2]0, %d3
.L15:
	movh.a	%a2, 61443
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	insert	%d3, %d3, 0, 0, 16
	or	%d2, %d3
	or	%d2, %d2, 2
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_clearSafetyEndinit
	.size Ifx_Ssw_clearSafetyEndinit, .-Ifx_Ssw_clearSafetyEndinit
	.global	Ifx_Ssw_clearSafetyEndinit_end
Ifx_Ssw_clearSafetyEndinit_end:
	.section	.text.Ifx_Ssw_setSafetyEndinit,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_setSafetyEndinit
	.type	Ifx_Ssw_setSafetyEndinit, @function
Ifx_Ssw_setSafetyEndinit:
	movh.a	%a2, 61443
	extr.u	%d2, %d4, 0, 16
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	sh	%d2, 2
	jz.t	%d3, 1, .L20
	ld.w	%d3, [%a2]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a2]0, %d3
.L20:
	movh.a	%a2, 61443
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	insert	%d3, %d3, 0, 0, 16
	or	%d2, %d3
	or	%d2, %d2, 3
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_setSafetyEndinit
	.size Ifx_Ssw_setSafetyEndinit, .-Ifx_Ssw_setSafetyEndinit
	.global	Ifx_Ssw_setSafetyEndinit_end
Ifx_Ssw_setSafetyEndinit_end:
	.section	.text.Ifx_Ssw_serviceCpuWatchdog,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_serviceCpuWatchdog
	.type	Ifx_Ssw_serviceCpuWatchdog, @function
Ifx_Ssw_serviceCpuWatchdog:
	extr.u	%d2, %d4, 0, 16
	ld.w	%d3, [%a4]0
	sh	%d2, 2
	jz.t	%d3, 1, .L25
	ld.w	%d3, [%a4]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a4]0, %d3
.L25:
	ld.w	%d3, [%a4]0
	insert	%d3, %d3, 0, 0, 16
	or	%d2, %d3
	or	%d2, %d2, 3
	st.w	[%a4]0, %d2
	ld.w	%d2, [%a4]0
	ret	#Ifx_Ssw_serviceCpuWatchdog
	.size Ifx_Ssw_serviceCpuWatchdog, .-Ifx_Ssw_serviceCpuWatchdog
	.global	Ifx_Ssw_serviceCpuWatchdog_end
Ifx_Ssw_serviceCpuWatchdog_end:
	.section	.text.Ifx_Ssw_serviceSafetyWatchdog,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_serviceSafetyWatchdog
	.type	Ifx_Ssw_serviceSafetyWatchdog, @function
Ifx_Ssw_serviceSafetyWatchdog:
	movh.a	%a2, 61443
	extr.u	%d2, %d4, 0, 16
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	sh	%d2, 2
	jz.t	%d3, 1, .L30
	ld.w	%d3, [%a2]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a2]0, %d3
.L30:
	movh.a	%a2, 61443
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	insert	%d3, %d3, 0, 0, 16
	or	%d2, %d3
	or	%d2, %d2, 3
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_serviceSafetyWatchdog
	.size Ifx_Ssw_serviceSafetyWatchdog, .-Ifx_Ssw_serviceSafetyWatchdog
	.global	Ifx_Ssw_serviceSafetyWatchdog_end
Ifx_Ssw_serviceSafetyWatchdog_end:
	.section	.text.Ifx_Ssw_disableCpuWatchdog,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_disableCpuWatchdog
	.type	Ifx_Ssw_disableCpuWatchdog, @function
Ifx_Ssw_disableCpuWatchdog:
	extr.u	%d2, %d4, 0, 16
#APP
	# 100 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.c" 1
	mfcr %d3, LO:0xFE1C
	# 0 "" 2
#NO_APP
	mov	%d4, 5
	and	%d3, %d3, 7
#APP
	# 172 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	min.u %d3, %d3, %d4
	# 0 "" 2
#NO_APP
	movh	%d4, 61443
	addi	%d4, %d4, 25164
	madd	%d3, %d4, %d3, 12
	sh	%d4, %d2, 2
	mov.a	%a2, %d3
	ld.w	%d3, [%a2]0
	jz.t	%d3, 1, .L35
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L35:
	ld.w	%d2, [%a2]0
	lea	%a3, [%a2] 4
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 2
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ld.w	%d2, [%a2] 4
	insert	%d2, %d2, 1, 3, 1
	st.w	[%a3]0, %d2
	ld.w	%d2, [%a2]0
	jz.t	%d2, 1, .L36
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L36:
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 3
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_disableCpuWatchdog
	.size Ifx_Ssw_disableCpuWatchdog, .-Ifx_Ssw_disableCpuWatchdog
	.global	Ifx_Ssw_disableCpuWatchdog_end
Ifx_Ssw_disableCpuWatchdog_end:
	.section	.text.Ifx_Ssw_enableCpuWatchdog,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_enableCpuWatchdog
	.type	Ifx_Ssw_enableCpuWatchdog, @function
Ifx_Ssw_enableCpuWatchdog:
	extr.u	%d2, %d4, 0, 16
#APP
	# 115 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_Infra.c" 1
	mfcr %d3, LO:0xFE1C
	# 0 "" 2
#NO_APP
	mov	%d4, 5
	and	%d3, %d3, 7
#APP
	# 172 "../Libraries/Infra/Ssw/TC3xx/Tricore/Ifx_Ssw_CompilersGcc.h" 1
	min.u %d3, %d3, %d4
	# 0 "" 2
#NO_APP
	movh	%d4, 61443
	addi	%d4, %d4, 25164
	madd	%d3, %d4, %d3, 12
	sh	%d4, %d2, 2
	mov.a	%a2, %d3
	ld.w	%d3, [%a2]0
	jz.t	%d3, 1, .L44
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L44:
	ld.w	%d2, [%a2]0
	lea	%a3, [%a2] 4
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 2
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ld.w	%d2, [%a2] 4
	andn	%d2, %d2, ~(-9)
	st.w	[%a3]0, %d2
	ld.w	%d2, [%a2]0
	jz.t	%d2, 1, .L45
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L45:
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 3
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_enableCpuWatchdog
	.size Ifx_Ssw_enableCpuWatchdog, .-Ifx_Ssw_enableCpuWatchdog
	.global	Ifx_Ssw_enableCpuWatchdog_end
Ifx_Ssw_enableCpuWatchdog_end:
	.section	.text.Ifx_Ssw_disableSafetyWatchdog,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_disableSafetyWatchdog
	.type	Ifx_Ssw_disableSafetyWatchdog, @function
Ifx_Ssw_disableSafetyWatchdog:
	movh.a	%a2, 61443
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	sh	%d4, 2
	jz.t	%d3, 1, .L53
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L53:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 25256
	movh.a	%a3, 61443
	insert	%d2, %d2, 0, 0, 16
	lea	%a3, [%a3] 25260
	or	%d2, %d4
	or	%d2, %d2, 2
	lea	%a2, [%a2] 25256
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ld.w	%d2, [%a3]0
	insert	%d2, %d2, 1, 3, 1
	st.w	[%a3]0, %d2
	ld.w	%d2, [%a2]0
	jz.t	%d2, 1, .L54
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L54:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 25256
	lea	%a2, [%a2] 25256
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 3
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_disableSafetyWatchdog
	.size Ifx_Ssw_disableSafetyWatchdog, .-Ifx_Ssw_disableSafetyWatchdog
	.global	Ifx_Ssw_disableSafetyWatchdog_end
Ifx_Ssw_disableSafetyWatchdog_end:
	.section	.text.Ifx_Ssw_enableSafetyWatchdog,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_enableSafetyWatchdog
	.type	Ifx_Ssw_enableSafetyWatchdog, @function
Ifx_Ssw_enableSafetyWatchdog:
	movh.a	%a2, 61443
	ld.w	%d3, [%a2] 25256
	lea	%a2, [%a2] 25256
	sh	%d4, 2
	jz.t	%d3, 1, .L62
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L62:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 25256
	movh.a	%a3, 61443
	insert	%d2, %d2, 0, 0, 16
	lea	%a3, [%a3] 25260
	or	%d2, %d4
	or	%d2, %d2, 2
	lea	%a2, [%a2] 25256
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ld.w	%d2, [%a3]0
	andn	%d2, %d2, ~(-9)
	st.w	[%a3]0, %d2
	ld.w	%d2, [%a2]0
	jz.t	%d2, 1, .L63
	ld.w	%d2, [%a2]0
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 1
	st.w	[%a2]0, %d2
.L63:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 25256
	lea	%a2, [%a2] 25256
	insert	%d2, %d2, 0, 0, 16
	or	%d2, %d4
	or	%d2, %d2, 3
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_enableSafetyWatchdog
	.size Ifx_Ssw_enableSafetyWatchdog, .-Ifx_Ssw_enableSafetyWatchdog
	.global	Ifx_Ssw_enableSafetyWatchdog_end
Ifx_Ssw_enableSafetyWatchdog_end:
	.section	.text.Ifx_Ssw_startCore,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_startCore
	.type	Ifx_Ssw_startCore, @function
Ifx_Ssw_startCore:
	movh	%d2, 2
	addi	%d2, %d2, -504
	addsc.a	%a2, %a4, %d2, 0
	ld.w	%d2, [%a2]0
	insert	%d2, %d4, %d2, 0, 1
	st.w	[%a2]0, %d2
	movh	%d2, 2
	addi	%d2, %d2, -492
	addsc.a	%a2, %a4, %d2, 0
	ld.w	%d2, [%a2]0
	jz.t	%d2, 24, .L70
	insert	%d2, %d2, 0, 24, 1
	st.w	[%a2]0, %d2
.L70:
	ret	#Ifx_Ssw_startCore
	.size Ifx_Ssw_startCore, .-Ifx_Ssw_startCore
	.global	Ifx_Ssw_startCore_end
Ifx_Ssw_startCore_end:
	.section	.text.Ifx_Ssw_setCpu0Idle,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_setCpu0Idle
	.type	Ifx_Ssw_setCpu0Idle, @function
Ifx_Ssw_setCpu0Idle:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 25164
	ld.w	%d3, [%a2] 25164
	extr.u	%d2, %d2, 2, 14
	lea	%a2, [%a2] 25164
	xor	%d2, %d2, 63
	sh	%d2, 2
	jz.t	%d3, 1, .L77
	ld.w	%d3, [%a2]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a2]0, %d3
.L77:
	movh.a	%a2, 61443
	ld.w	%d3, [%a2] 25164
	movh.a	%a3, 61443
	insert	%d3, %d3, 0, 0, 16
	lea	%a3, [%a3] 24776
	or	%d3, %d2
	or	%d3, %d3, 2
	lea	%a2, [%a2] 25164
	st.w	[%a2]0, %d3
	ld.w	%d3, [%a2]0
	ld.w	%d3, [%a3]0
	insert	%d3, %d3, 1, 0, 2
	st.w	[%a3]0, %d3
	ld.w	%d3, [%a2]0
	jz.t	%d3, 1, .L78
	ld.w	%d3, [%a2]0
	insert	%d3, %d3, 0, 0, 16
	or	%d3, %d2
	or	%d3, %d3, 1
	st.w	[%a2]0, %d3
.L78:
	movh.a	%a2, 61443
	ld.w	%d3, [%a2] 25164
	lea	%a2, [%a2] 25164
	insert	%d3, %d3, 0, 0, 16
	or	%d2, %d3
	or	%d2, %d2, 3
	st.w	[%a2]0, %d2
	ld.w	%d2, [%a2]0
	ret	#Ifx_Ssw_setCpu0Idle
	.size Ifx_Ssw_setCpu0Idle, .-Ifx_Ssw_setCpu0Idle
	.global	Ifx_Ssw_setCpu0Idle_end
Ifx_Ssw_setCpu0Idle_end:
	.section	.text.Ifx_Ssw_getStmFrequency,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_getStmFrequency
	.type	Ifx_Ssw_getStmFrequency, @function
Ifx_Ssw_getStmFrequency:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 24600
	movh	%d4, 19353
	sh	%d2, %d2, -30
	add	%d2, -1
	lea	%a2, [%a2] 24600
	addi	%d4, %d4, -27008
	jlt.u	%d2, 2, .L83
	movh	%d4, 19647
	addi	%d4, %d4, -17376
.L83:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 24624
	movh	%d3, 19647
	extr.u	%d2, %d2, 28, 2
	lea	%a2, [%a2] 24624
	addi	%d3, %d3, -17376
	jz	%d2, .L84
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 24600
	lea	%a2, [%a2] 24600
	ld.w	%d5, [%a2]0
	extr.u	%d2, %d2, 9, 7
	movh.a	%a2, 61443
	add	%d2, 1
	ld.w	%d6, [%a2] 24604
	itof	%d2, %d2
	extr.u	%d5, %d5, 24, 3
	and	%d6, %d6, 7
	mul.f	%d3, %d2, %d4
	addi	%d2, %d6, 1
	madd	%d2, %d2, %d5, %d2
	lea	%a2, [%a2] 24604
	itof	%d2, %d2
	div.f	%d3, %d3, %d2
.L84:
	movh.a	%a2, 61443
	ld.w	%d2, [%a2] 24624
	lea	%a2, [%a2] 24624
	and	%d2, %d2, 15
	itof	%d2, %d2
	div.f	%d2, %d3, %d2
	ret	#Ifx_Ssw_getStmFrequency
	.size Ifx_Ssw_getStmFrequency, .-Ifx_Ssw_getStmFrequency
	.global	Ifx_Ssw_getStmFrequency_end
Ifx_Ssw_getStmFrequency_end:
	.section	.text.Ifx_Ssw_doCppInit,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_doCppInit
	.type	Ifx_Ssw_doCppInit, @function
Ifx_Ssw_doCppInit:
	movh.a	%a2, hi:__clear_table
	ld.w	%d2, [%a2] lo:__clear_table
	sub.a	%SP, 8
	lea	%a7, [%a2] lo:__clear_table
	st.w	[%SP]0, %d2
	ld.w	%d2, [%a7] 4
	jeq	%d2, -1, .L89
	mov	%d5, 0
	lea	%a7, [%a7] 8
	mov.a	%a2, 0
	mov.a	%a3, 0
	mov	%d4, %d5
	mov	%d6, %d5
.L96:
	sh	%d3, %d2, -3
	mov.a	%a4, %d3
	lea	%a6, [%a4] -1
	jz	%d3, .L90
	and	%d3, %d3, 7
	jz	%d3, .L91
	jeq	%d3, 1, .L173
	jeq	%d3, 2, .L174
	jeq	%d3, 3, .L175
	jeq	%d3, 4, .L176
	jeq	%d3, 5, .L177
	jeq	%d3, 6, .L178
	ld.a	%a4, [%SP]0
	add.a	%a6, -1
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
.L178:
	ld.a	%a4, [%SP]0
	add.a	%a6, -1
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
.L177:
	ld.a	%a4, [%SP]0
	add.a	%a6, -1
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
.L176:
	ld.a	%a4, [%SP]0
	add.a	%a6, -1
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
.L175:
	ld.a	%a4, [%SP]0
	add.a	%a6, -1
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
.L174:
	ld.a	%a4, [%SP]0
	add.a	%a6, -1
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
.L173:
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	loop	%a6, .L91
.L90:
	jz.t	%d2, 2, .L92
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 4
	st.a	[%SP]0, %a5
	st.w	[%a4]0, %d5
.L92:
	jz.t	%d2, 1, .L93
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 2
	st.a	[%SP]0, %a5
	st.h	[%a4]0, %d4
.L93:
	jz.t	%d2, 0, .L94
	ld.a	%a4, [%SP]0
	st.b	[%a4]0, %d6
.L94:
	mov.aa	%a4, %a7
	ld.w	%d2, [%a4]0
	lea	%a7, [%a7] 8
	st.w	[%SP]0, %d2
	ld.w	%d2, [%a7] -4
	jne	%d2, -1, .L96
.L89:
	movh.a	%a3, hi:__copy_table
	ld.w	%d2, [%a3] lo:__copy_table
	lea	%a6, [%a3] lo:__copy_table
	st.w	[%SP] 4, %d2
	ld.w	%d2, [%a6] 4
	st.w	[%SP]0, %d2
	ld.w	%d2, [%a6] 8
	jeq	%d2, -1, .L97
	lea	%a6, [%a6] 12
.L104:
	sh	%d3, %d2, -3
	mov.a	%a2, %d3
	lea	%a5, [%a2] -1
	jz	%d3, .L98
	and	%d3, %d3, 7
	jz	%d3, .L99
	jeq	%d3, 1, .L179
	jeq	%d3, 2, .L180
	jeq	%d3, 3, .L181
	jeq	%d3, 4, .L182
	jeq	%d3, 5, .L183
	jeq	%d3, 6, .L184
	ld.a	%a2, [%SP] 4
	add.a	%a5, -1
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
.L184:
	ld.a	%a2, [%SP] 4
	add.a	%a5, -1
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
.L183:
	ld.a	%a2, [%SP] 4
	add.a	%a5, -1
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
.L182:
	ld.a	%a2, [%SP] 4
	add.a	%a5, -1
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
.L181:
	ld.a	%a2, [%SP] 4
	add.a	%a5, -1
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
.L180:
	ld.a	%a2, [%SP] 4
	add.a	%a5, -1
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
.L179:
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	loop	%a5, .L99
.L98:
	jz.t	%d2, 2, .L100
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 4
	st.a	[%SP] 4, %a3
	ld.a	%a3, [%SP]0
	ld.w	%d3, [%a2]0
	lea	%a4, [%a3] 4
	st.a	[%SP]0, %a4
	st.w	[%a3]0, %d3
.L100:
	jz.t	%d2, 1, .L101
	ld.a	%a3, [%SP] 4
	lea	%a2, [%a3] 2
	st.a	[%SP] 4, %a2
	ld.a	%a2, [%SP]0
	ld.hu	%d3, [%a3]0
	lea	%a4, [%a2] 2
	st.a	[%SP]0, %a4
	st.h	[%a2]0, %d3
.L101:
	jz.t	%d2, 0, .L102
	ld.a	%a3, [%SP] 4
	ld.a	%a2, [%SP]0
	ld.bu	%d2, [%a3]0
	st.b	[%a2]0, %d2
.L102:
	ld.w	%d2, [%a6]0
	st.w	[%SP] 4, %d2
	lea	%a6, [%a6] 12
	ld.w	%d2, [%a6] -8
	st.w	[%SP]0, %d2
	ld.w	%d2, [%a6] -4
	jne	%d2, -1, .L104
.L97:
	call	_init
	ret	#Ifx_Ssw_doCppInit
.L91:
	ld.a	%a4, [%SP]0
	add.a	%a6, -8
	mov.d	%d3, %a6
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	ld.a	%a4, [%SP]0
	lea	%a5, [%a4] 8
	st.a	[%SP]0, %a5
	st.da	[%a4]0, %A2
	jne	%d3, -1, .L91
	j	.L90
.L99:
	ld.a	%a2, [%SP] 4
	add.a	%a5, -8
	mov.d	%d3, %a5
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	ld.a	%a2, [%SP] 4
	lea	%a3, [%a2] 8
	st.a	[%SP] 4, %a3
	ld.a	%a4, [%SP]0
	lea	%a3, [%a4] 8
	st.a	[%SP]0, %a3
	ld.da	%A2, [%a2]0
	st.da	[%a4]0, %A2
	jne	%d3, -1, .L99
	j	.L98
	.size Ifx_Ssw_doCppInit, .-Ifx_Ssw_doCppInit
	.global	Ifx_Ssw_doCppInit_end
Ifx_Ssw_doCppInit_end:
	.section	.text.Ifx_Ssw_doCppExit,"ax",@progbits
	.align 1
	.global	Ifx_Ssw_doCppExit
	.type	Ifx_Ssw_doCppExit, @function
Ifx_Ssw_doCppExit:
	call	exit
	.size Ifx_Ssw_doCppExit, .-Ifx_Ssw_doCppExit
	.global	Ifx_Ssw_doCppExit_end
Ifx_Ssw_doCppExit_end:
	.extern	exit,STT_FUNC,0
	.extern	_init,STT_FUNC,0
	.extern	__copy_table,STT_OBJECT,-1
	.extern	__clear_table,STT_OBJECT,-1
	.ident	"GCC: (AURIX(tm) GCC - Built 2026-03-19 10:32:43) 11.3.1 20221230"
.section .callinfo
  .word Ifx_Ssw_getCpuWatchdogPassword #name
  .word Ifx_Ssw_getCpuWatchdogPassword_end #sz
  .word 0x00100004 #reg
  .word 0x00100000 #arg
  .word 0x00000004 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_getSafetyWatchdogPassword #name
  .word Ifx_Ssw_getSafetyWatchdogPassword_end #sz
  .word 0x00040004 #reg
  .word 0x00000000 #arg
  .word 0x00000004 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_clearCpuEndinit #name
  .word Ifx_Ssw_clearCpuEndinit_end #sz
  .word 0x0010001c #reg
  .word 0x00100010 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_setCpuEndinit #name
  .word Ifx_Ssw_setCpuEndinit_end #sz
  .word 0x0010001c #reg
  .word 0x00100010 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_clearSafetyEndinit #name
  .word Ifx_Ssw_clearSafetyEndinit_end #sz
  .word 0x0004001c #reg
  .word 0x00000010 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_setSafetyEndinit #name
  .word Ifx_Ssw_setSafetyEndinit_end #sz
  .word 0x0004001c #reg
  .word 0x00000010 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_serviceCpuWatchdog #name
  .word Ifx_Ssw_serviceCpuWatchdog_end #sz
  .word 0x0010001c #reg
  .word 0x00100010 #arg
  .word 0x00000000 #ret
  .word 0x000000a0 #stat
  .word Ifx_Ssw_serviceSafetyWatchdog #name
  .word Ifx_Ssw_serviceSafetyWatchdog_end #sz
  .word 0x0004001c #reg
  .word 0x00000010 #arg
  .word 0x00000000 #ret
  .word 0x000000a0 #stat
  .word Ifx_Ssw_disableCpuWatchdog #name
  .word Ifx_Ssw_disableCpuWatchdog_end #sz
  .word 0x000c001c #reg
  .word 0x00100010 #arg
  .word 0x00000000 #ret
  .word 0x00000180 #stat
  .word Ifx_Ssw_enableCpuWatchdog #name
  .word Ifx_Ssw_enableCpuWatchdog_end #sz
  .word 0x000c001c #reg
  .word 0x00100010 #arg
  .word 0x00000000 #ret
  .word 0x00000180 #stat
  .word Ifx_Ssw_disableSafetyWatchdog #name
  .word Ifx_Ssw_disableSafetyWatchdog_end #sz
  .word 0x000c001c #reg
  .word 0x00000010 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_enableSafetyWatchdog #name
  .word Ifx_Ssw_enableSafetyWatchdog_end #sz
  .word 0x000c001c #reg
  .word 0x00000010 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_startCore #name
  .word Ifx_Ssw_startCore_end #sz
  .word 0x0014001c #reg
  .word 0x00100010 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_setCpu0Idle #name
  .word Ifx_Ssw_setCpu0Idle_end #sz
  .word 0x000c000c #reg
  .word 0x00000000 #arg
  .word 0x00000000 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_getStmFrequency #name
  .word Ifx_Ssw_getStmFrequency_end #sz
  .word 0x0004007c #reg
  .word 0x00000000 #arg
  .word 0x00000004 #ret
  .word 0x00000080 #stat
  .word Ifx_Ssw_doCppInit #name
  .word Ifx_Ssw_doCppInit_end #sz
  .word 0x04fc007c #reg
  .word 0x00000000 #arg
  .word 0x00000000 #ret
  .word 0x00028000 #stat
  .word Ifx_Ssw_doCppExit #name
  .word Ifx_Ssw_doCppExit_end #sz
  .word 0x04000010 #reg
  .word 0x00000010 #arg
  .word 0x00000000 #ret
  .word 0x00021000 #stat
