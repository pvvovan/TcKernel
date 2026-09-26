# tric_asm_file_start
	.file	"IfxPmsEvr.c"
	.file	"IfxPmsEvr.c"
.section .text,"ax",@progbits
	.section	.text.IfxPmsEvr_filterSecondaryConversionResult,"ax",@progbits
	.align 1
	.global	IfxPmsEvr_filterSecondaryConversionResult
	.type	IfxPmsEvr_filterSecondaryConversionResult, @function
IfxPmsEvr_filterSecondaryConversionResult:
	mov.aa	%a12, %a4
	mov	%d9, %d4
	mov	%d10, %d5
	call	IfxScuWdt_getSafetyWatchdogPassword
	mov	%d4, %d2
	mov	%d8, %d2
	call	IfxScuWdt_clearSafetyEndinit
	ld.w	%d3, [%a12] 112
	jge.u	%d10, 6, .L2
	movh.a	%a2, hi:.L4
	lea	%a2, [%a2] lo:.L4
	addsc.a	%a2, %a2, %d10, 2
	ji	%a2
	.align 2
	.align 2
.L4:
	.code32
	j	.L9
	.code32
	j	.L8
	.code32
	j	.L7
	.code32
	j	.L6
	.code32
	j	.L5
	.code32
	j	.L3
.L3:
	insert	%d3, %d3, %d9, 20, 4
.L2:
	st.w	[%a12] 112, %d3
	mov	%d4, %d8
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_filterSecondaryConversionResult
.L5:
	insert	%d3, %d3, %d9, 12, 4
	mov	%d4, %d8
	st.w	[%a12] 112, %d3
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_filterSecondaryConversionResult
.L9:
	insert	%d3, %d3, %d9, 0, 4
	mov	%d4, %d8
	st.w	[%a12] 112, %d3
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_filterSecondaryConversionResult
.L8:
	insert	%d3, %d3, %d9, 8, 4
	mov	%d4, %d8
	st.w	[%a12] 112, %d3
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_filterSecondaryConversionResult
.L7:
	insert	%d3, %d3, %d9, 16, 4
	mov	%d4, %d8
	st.w	[%a12] 112, %d3
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_filterSecondaryConversionResult
.L6:
	insert	%d3, %d3, %d9, 4, 4
	mov	%d4, %d8
	st.w	[%a12] 112, %d3
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_filterSecondaryConversionResult
	.size IfxPmsEvr_filterSecondaryConversionResult, .-IfxPmsEvr_filterSecondaryConversionResult
	.global	IfxPmsEvr_filterSecondaryConversionResult_end
IfxPmsEvr_filterSecondaryConversionResult_end:
	.section	.text.IfxPmsEvr_getSecondaryAdcResult,"ax",@progbits
	.align 1
	.global	IfxPmsEvr_getSecondaryAdcResult
	.type	IfxPmsEvr_getSecondaryAdcResult, @function
IfxPmsEvr_getSecondaryAdcResult:
	mov	%d2, 0
	jge.u	%d4, 6, .L12
	movh.a	%a3, hi:.L14
	lea	%a3, [%a3] lo:.L14
	addsc.a	%a3, %a3, %d4, 2
	ji	%a3
	.align 2
	.align 2
.L14:
	.code32
	j	.L19
	.code32
	j	.L18
	.code32
	j	.L17
	.code32
	j	.L16
	.code32
	j	.L15
	.code32
	j	.L13
.L15:
	ld.w	%d2, [%a4] 100
	extr.u	%d2, %d2, 16, 8
.L12:
	ret	#IfxPmsEvr_getSecondaryAdcResult
.L13:
	ld.w	%d2, [%a4] 100
	extr.u	%d2, %d2, 8, 8
	ret	#IfxPmsEvr_getSecondaryAdcResult
.L19:
	ld.w	%d2, [%a4] 96
	and	%d2, %d2, 255
	ret	#IfxPmsEvr_getSecondaryAdcResult
.L18:
	ld.w	%d2, [%a4] 96
	extr.u	%d2, %d2, 8, 8
	ret	#IfxPmsEvr_getSecondaryAdcResult
.L17:
	ld.w	%d2, [%a4] 96
	extr.u	%d2, %d2, 16, 8
	ret	#IfxPmsEvr_getSecondaryAdcResult
.L16:
	ld.w	%d2, [%a4] 100
	and	%d2, %d2, 255
	ret	#IfxPmsEvr_getSecondaryAdcResult
	.size IfxPmsEvr_getSecondaryAdcResult, .-IfxPmsEvr_getSecondaryAdcResult
	.global	IfxPmsEvr_getSecondaryAdcResult_end
IfxPmsEvr_getSecondaryAdcResult_end:
	.section	.text.IfxPmsEvr_setSecondaryOverVoltageThresholdMv,"ax",@progbits
	.align 1
	.global	IfxPmsEvr_setSecondaryOverVoltageThresholdMv
	.type	IfxPmsEvr_setSecondaryOverVoltageThresholdMv, @function
IfxPmsEvr_setSecondaryOverVoltageThresholdMv:
	mov.aa	%a12, %a4
	mov	%d10, %d5
	mov	%d9, %d4
	call	IfxScuWdt_getSafetyWatchdogPassword
	mov	%d4, %d2
	mov	%d8, %d2
	call	IfxScuWdt_clearSafetyEndinit
	ld.w	%d3, [%a12] 124
	ld.w	%d2, [%a12] 132
	mov	%d5, %d3
	mov	%d4, %d2
	jge.u	%d10, 6, .L22
	movh.a	%a2, hi:.L24
	lea	%a2, [%a2] lo:.L24
	addsc.a	%a2, %a2, %d10, 2
	ji	%a2
	.align 2
	.align 2
.L24:
	.code32
	j	.L29
	.code32
	j	.L28
	.code32
	j	.L27
	.code32
	j	.L26
	.code32
	j	.L25
	.code32
	j	.L23
.L23:
	movh	%d2, 16825
	addi	%d2, %d2, -25166
	div.f	%d9, %d9, %d2
	movh	%d2, 16256
	add.f	%d2, %d9, %d2
	ftouz	%d2, %d2
	insert	%d2, %d4, %d2, 16, 8
.L22:
	st.w	[%a12] 124, %d3
	st.w	[%a12] 132, %d2
	mov	%d4, %d8
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryOverVoltageThresholdMv
.L25:
	movh	%d2, 16825
	addi	%d2, %d2, -25166
	div.f	%d9, %d9, %d2
	movh	%d2, 16256
	st.w	[%a12] 124, %d3
	add.f	%d2, %d9, %d2
	ftouz	%d2, %d2
	insert	%d2, %d4, %d2, 8, 8
	mov	%d4, %d8
	st.w	[%a12] 132, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryOverVoltageThresholdMv
.L29:
	movh	%d3, 16569
	addi	%d3, %d3, -25271
	div.f	%d9, %d9, %d3
	movh	%d3, 16256
	mov	%d4, %d8
	add.f	%d3, %d9, %d3
	ftouz	%d3, %d3
	insert	%d3, %d5, %d3, 0, 8
	st.w	[%a12] 124, %d3
	st.w	[%a12] 132, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryOverVoltageThresholdMv
.L28:
	movh	%d3, 16752
	div.f	%d9, %d9, %d3
	movh	%d3, 16256
	mov	%d4, %d8
	add.f	%d3, %d9, %d3
	ftouz	%d3, %d3
	insert	%d3, %d5, %d3, 8, 8
	st.w	[%a12] 124, %d3
	st.w	[%a12] 132, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryOverVoltageThresholdMv
.L27:
	movh	%d3, 16825
	addi	%d3, %d3, -25166
	div.f	%d9, %d9, %d3
	movh	%d3, 16256
	mov	%d4, %d8
	add.f	%d3, %d9, %d3
	ftouz	%d3, %d3
	insert	%d3, %d5, %d3, 16, 8
	st.w	[%a12] 124, %d3
	st.w	[%a12] 132, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryOverVoltageThresholdMv
.L26:
	movh	%d2, 16569
	addi	%d2, %d2, -25271
	div.f	%d9, %d9, %d2
	movh	%d2, 16256
	st.w	[%a12] 124, %d3
	add.f	%d2, %d9, %d2
	ftouz	%d2, %d2
	insert	%d2, %d4, %d2, 0, 8
	mov	%d4, %d8
	st.w	[%a12] 132, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryOverVoltageThresholdMv
	.size IfxPmsEvr_setSecondaryOverVoltageThresholdMv, .-IfxPmsEvr_setSecondaryOverVoltageThresholdMv
	.global	IfxPmsEvr_setSecondaryOverVoltageThresholdMv_end
IfxPmsEvr_setSecondaryOverVoltageThresholdMv_end:
	.section	.text.IfxPmsEvr_setSecondaryUnderVoltageThresholdMv,"ax",@progbits
	.align 1
	.global	IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
	.type	IfxPmsEvr_setSecondaryUnderVoltageThresholdMv, @function
IfxPmsEvr_setSecondaryUnderVoltageThresholdMv:
	mov.aa	%a12, %a4
	mov	%d10, %d5
	mov	%d9, %d4
	call	IfxScuWdt_getSafetyWatchdogPassword
	mov	%d4, %d2
	mov	%d8, %d2
	call	IfxScuWdt_clearSafetyEndinit
	ld.w	%d3, [%a12] 120
	ld.w	%d2, [%a12] 128
	mov	%d5, %d3
	mov	%d4, %d2
	jge.u	%d10, 6, .L31
	movh.a	%a2, hi:.L33
	lea	%a2, [%a2] lo:.L33
	addsc.a	%a2, %a2, %d10, 2
	ji	%a2
	.align 2
	.align 2
.L33:
	.code32
	j	.L38
	.code32
	j	.L37
	.code32
	j	.L36
	.code32
	j	.L35
	.code32
	j	.L34
	.code32
	j	.L32
.L32:
	movh	%d2, 16825
	addi	%d2, %d2, -25166
	div.f	%d9, %d9, %d2
	movh	%d2, 16256
	add.f	%d2, %d9, %d2
	ftouz	%d2, %d2
	insert	%d2, %d4, %d2, 16, 8
.L31:
	st.w	[%a12] 120, %d3
	st.w	[%a12] 128, %d2
	mov	%d4, %d8
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
.L34:
	movh	%d2, 16825
	addi	%d2, %d2, -25166
	div.f	%d9, %d9, %d2
	movh	%d2, 16256
	st.w	[%a12] 120, %d3
	add.f	%d2, %d9, %d2
	ftouz	%d2, %d2
	insert	%d2, %d4, %d2, 8, 8
	mov	%d4, %d8
	st.w	[%a12] 128, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
.L38:
	movh	%d3, 16569
	addi	%d3, %d3, -25271
	div.f	%d9, %d9, %d3
	movh	%d3, 16256
	mov	%d4, %d8
	add.f	%d3, %d9, %d3
	ftouz	%d3, %d3
	insert	%d3, %d5, %d3, 0, 8
	st.w	[%a12] 120, %d3
	st.w	[%a12] 128, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
.L37:
	movh	%d3, 16752
	div.f	%d9, %d9, %d3
	movh	%d3, 16256
	mov	%d4, %d8
	add.f	%d3, %d9, %d3
	ftouz	%d3, %d3
	insert	%d3, %d5, %d3, 8, 8
	st.w	[%a12] 120, %d3
	st.w	[%a12] 128, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
.L36:
	movh	%d3, 16825
	addi	%d3, %d3, -25166
	div.f	%d9, %d9, %d3
	movh	%d3, 16256
	mov	%d4, %d8
	add.f	%d3, %d9, %d3
	ftouz	%d3, %d3
	insert	%d3, %d5, %d3, 16, 8
	st.w	[%a12] 120, %d3
	st.w	[%a12] 128, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
.L35:
	movh	%d2, 16569
	addi	%d2, %d2, -25271
	div.f	%d9, %d9, %d2
	movh	%d2, 16256
	st.w	[%a12] 120, %d3
	add.f	%d2, %d9, %d2
	ftouz	%d2, %d2
	insert	%d2, %d4, %d2, 0, 8
	mov	%d4, %d8
	st.w	[%a12] 128, %d2
	call	IfxScuWdt_setSafetyEndinit
	ret	#IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
	.size IfxPmsEvr_setSecondaryUnderVoltageThresholdMv, .-IfxPmsEvr_setSecondaryUnderVoltageThresholdMv
	.global	IfxPmsEvr_setSecondaryUnderVoltageThresholdMv_end
IfxPmsEvr_setSecondaryUnderVoltageThresholdMv_end:
	.global	IfxPmsEvr_checkRegCfgDefault
	.section	.rodata.IfxPmsEvr_checkRegCfgDefault,"a"
	.align 2
	.type	IfxPmsEvr_checkRegCfgDefault, @object
	.size	IfxPmsEvr_checkRegCfgDefault, 8
IfxPmsEvr_checkRegCfgDefault:
	.byte	22
	.zero	3
	.word	IfxPmsEvr_checkRegValuesDefault
	.global	IfxPmsEvr_checkRegValuesDefault
	.section	.rodata.IfxPmsEvr_checkRegValuesDefault,"a"
	.align 2
	.type	IfxPmsEvr_checkRegValuesDefault, @object
	.size	IfxPmsEvr_checkRegValuesDefault, 264
IfxPmsEvr_checkRegValuesDefault:
	.word	-266043040
	.word	8861698
	.word	-1
	.word	-266043036
	.word	53350
	.word	-1
	.word	-266043032
	.word	473090
	.word	-1
	.word	-266043028
	.word	38950
	.word	-1
	.word	-266043100
	.word	201
	.word	-1
	.word	-266043124
	.word	191432456
	.word	-1
	.word	-266043096
	.word	18941070
	.word	-1
	.word	-266043064
	.word	889746358
	.word	-1
	.word	-266043060
	.word	43281478
	.word	-1
	.word	-266043128
	.word	808845314
	.word	-1
	.word	-266043120
	.word	3539771
	.word	-1
	.word	-266043116
	.word	191432720
	.word	-1
	.word	-266043056
	.word	872968462
	.word	-1
	.word	-266043052
	.word	43281476
	.word	-1
	.word	-266043112
	.word	3538953
	.word	-1
	.word	-266043108
	.word	191432712
	.word	-1
	.word	-266043104
	.word	2301076
	.word	-1
	.word	-266043048
	.word	453518006
	.word	-1
	.word	-266043044
	.word	43281478
	.word	-1
	.word	-266043092
	.word	1076
	.word	-1
	.word	-266043088
	.word	23170
	.word	-1
	.word	-266043084
	.word	302450953
	.word	-1
	.global	IfxPmsEvr_cfgSequenceDefault
	.section	.rodata.IfxPmsEvr_cfgSequenceDefault,"a"
	.align 2
	.type	IfxPmsEvr_cfgSequenceDefault, @object
	.size	IfxPmsEvr_cfgSequenceDefault, 8
IfxPmsEvr_cfgSequenceDefault:
	.byte	3
	.zero	3
	.word	IfxPmsEvr_cfgPhasesDefault
	.global	IfxPmsEvr_cfgPhasesDefault
	.section	.rodata.IfxPmsEvr_cfgPhasesDefault,"a"
	.align 2
	.type	IfxPmsEvr_cfgPhasesDefault, @object
	.size	IfxPmsEvr_cfgPhasesDefault, 36
IfxPmsEvr_cfgPhasesDefault:
	.byte	8
	.zero	3
	.word	IfxPmsEvr_cfgPhase1Default
	.word	933741996
	.byte	2
	.zero	3
	.word	IfxPmsEvr_cfgPhase2Default
	.word	933741996
	.byte	13
	.zero	3
	.word	IfxPmsEvr_cfgPhase3Default
	.word	933741996
	.global	IfxPmsEvr_cfgPhase3Default
	.section	.rodata.IfxPmsEvr_cfgPhase3Default,"a"
	.align 2
	.type	IfxPmsEvr_cfgPhase3Default, @object
	.size	IfxPmsEvr_cfgPhase3Default, 156
IfxPmsEvr_cfgPhase3Default:
	.word	-266043128
	.word	808845314
	.word	-1
	.word	-266043120
	.word	3539771
	.word	-1
	.word	-266043116
	.word	191432720
	.word	-1
	.word	-266043056
	.word	872968462
	.word	-1
	.word	-266043052
	.word	43281476
	.word	-1
	.word	-266043112
	.word	3538953
	.word	-1
	.word	-266043108
	.word	191432712
	.word	-1
	.word	-266043104
	.word	2301076
	.word	-1
	.word	-266043048
	.word	453518006
	.word	-1
	.word	-266043044
	.word	43281478
	.word	-1
	.word	-266043092
	.word	1076
	.word	-1
	.word	-266043088
	.word	23170
	.word	-1
	.word	-266043084
	.word	302450953
	.word	-1
	.global	IfxPmsEvr_cfgPhase2Default
	.section	.rodata.IfxPmsEvr_cfgPhase2Default,"a"
	.align 2
	.type	IfxPmsEvr_cfgPhase2Default, @object
	.size	IfxPmsEvr_cfgPhase2Default, 24
IfxPmsEvr_cfgPhase2Default:
	.word	-266043064
	.word	889746358
	.word	-1
	.word	-266043060
	.word	43281478
	.word	-1
	.global	IfxPmsEvr_cfgPhase1Default
	.section	.rodata.IfxPmsEvr_cfgPhase1Default,"a"
	.align 2
	.type	IfxPmsEvr_cfgPhase1Default, @object
	.size	IfxPmsEvr_cfgPhase1Default, 96
IfxPmsEvr_cfgPhase1Default:
	.word	-266043040
	.word	8861698
	.word	-1
	.word	-266043036
	.word	53350
	.word	-1
	.word	-266043032
	.word	473090
	.word	-1
	.word	-266043028
	.word	38950
	.word	-1
	.word	-266043100
	.word	201
	.word	-1
	.word	-266043128
	.word	808845313
	.word	-1
	.word	-266043124
	.word	191432456
	.word	-1
	.word	-266043096
	.word	18941070
	.word	-1
	.extern	IfxScuWdt_setSafetyEndinit,STT_FUNC,0
	.extern	IfxScuWdt_clearSafetyEndinit,STT_FUNC,0
	.extern	IfxScuWdt_getSafetyWatchdogPassword,STT_FUNC,0
	.ident	"GCC: (AURIX(tm) GCC - Built 2026-03-19 10:32:43) 11.3.1 20221230"
.section .callinfo
  .word IfxPmsEvr_filterSecondaryConversionResult #name
  .word IfxPmsEvr_filterSecondaryConversionResult_end #sz
  .word 0x1414073c #reg
  .word 0x00100030 #arg
  .word 0x00000000 #ret
  .word 0x00020000 #stat
  .word IfxPmsEvr_getSecondaryAdcResult #name
  .word IfxPmsEvr_getSecondaryAdcResult_end #sz
  .word 0x001c0014 #reg
  .word 0x00100010 #arg
  .word 0x00000004 #ret
  .word 0x00000080 #stat
  .word IfxPmsEvr_setSecondaryOverVoltageThresholdMv #name
  .word IfxPmsEvr_setSecondaryOverVoltageThresholdMv_end #sz
  .word 0x1414073c #reg
  .word 0x00100030 #arg
  .word 0x00000000 #ret
  .word 0x00020000 #stat
  .word IfxPmsEvr_setSecondaryUnderVoltageThresholdMv #name
  .word IfxPmsEvr_setSecondaryUnderVoltageThresholdMv_end #sz
  .word 0x1414073c #reg
  .word 0x00100030 #arg
  .word 0x00000000 #ret
  .word 0x00020000 #stat
