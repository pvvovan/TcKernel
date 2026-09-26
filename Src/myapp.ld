OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x380;

MEMORY
{
	DSPR0	(w!xp): org = 0x70000000, len = 240K
	PFLASH0	(rx!p): org = 0x80000000, len = 3M
}

SECTIONS
{
	.text 0x80000020 :
	{
		*(.start)
		*(.text*)
		*(.init)
		*(.fini)
	} > PFLASH0

	.rodata :
	{
		. = ALIGN(8);
		*(.rodata*)
	} > PFLASH0

	.data :
	{
		. = ALIGN(8);
		*(.zdata)
		*(.data*)
	} > DSPR0 AT > PFLASH0

	.bss :
	{
		. = ALIGN(8);
		*(.bss*)
	} > DSPR0

	.csa :
	{
		. = ALIGN(64);
		__CSA0 = .;
		. += 16K;
		__CSA0_END = .;
	}

	__USTACK0 = ORIGIN(DSPR0) + LENGTH(DSPR0);

	/* TODO: fix me */
	__TRAPTAB_CPU0 = 0;
	__INTTAB_CPU0 = 0;
	__ISTACK0 = 0;
	__A0_MEM = 0;
	__A1_MEM = 0;
	__A8_MEM = 0;
	__A9_MEM = 0;
	__clear_table = 0;
	__copy_table = 0;

	.comment	0 : { *(.comment) }
	.debug_abbrev	0 : { *(.debug_abbrev) }
	.debug_aranges	0 : { *(.debug_aranges) }
	.debug_frame	0 : { *(.debug_frame) }
	.debug_info	0 : { *(.debug_info) }
	.debug_line	0 : { *(.debug_line) }
	.debug_macro	0 : { *(.debug_macro) }
	.debug_ranges	0 : { *(.debug_ranges) }
	.debug_rnglists	0 : { *(.debug_rnglists) }
	.debug_str	0 : { *(.debug_str) }
}
