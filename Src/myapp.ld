OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x380;

MEMORY
{
	DSPR0	(w!xp): ORIGIN = 0x70000000,	LENGTH = 240K
	PFLASH0	(rx!p): ORIGIN = 0x80000000,	LENGTH = 3M
}

__USTACK0 = ORIGIN(DSPR0) + LENGTH(DSPR0);

SECTIONS
{
	.zrodata ORIGIN(PFLASH0) :
	{
		*(.zrodata);
		*(.zrodata.*);
		. = 16K; /* Reserve 14-bit space for absolute addressing */
	} > PFLASH0

	.zbss ORIGIN(DSPR0) :
	{
		*(.zbss)
		*(.zbss.*)
	} > DSPR0
	.zdata : ALIGN(8)
	{
		*(.zdata)
		*(.zdata.*)
	} > DSPR0 AT > PFLASH0

	.text : ALIGN(16)
	{
		*(.start)
		*(.init)
		*(.fini)
		*(.text)
		*(.text.*)
	} > PFLASH0

	.data : ALIGN(8)
	{
		*(.data)
		*(.data.*)
	} > DSPR0 AT > PFLASH0

	.bss : ALIGN(8)
	{
		*(.bss)
		*(.bss.*)
	} > DSPR0

	.csa : ALIGN(64)
	{
		__CSA0 = .;
		. += 16K;
		__CSA0_END = .;
	}

	.rodata : ALIGN(8)
	{
		*(.rodata)
		*(.rodata.*)

		. = ALIGN(4);
		__clear_table = .;
		LONG(ABSOLUTE(ADDR(.bss)));		LONG(SIZEOF(.bss));
		LONG(ABSOLUTE(ADDR(.zbss)));		LONG(SIZEOF(.zbss));
		LONG(-1);				LONG(-1);

		. = ALIGN(4);
		__copy_table = .;
		LONG(LOADADDR(.zdata));			LONG(ABSOLUTE(ADDR(.zdata)));		LONG(SIZEOF(.zdata));
		LONG(LOADADDR(.data));			LONG(ABSOLUTE(ADDR(.data)));		LONG(SIZEOF(.data));
		LONG(-1);				LONG(-1);				LONG(-1);
	} > PFLASH0

	/* TODO: fix me */
	__TRAPTAB_CPU0 = 0;
	__INTTAB_CPU0 = 0;
	__ISTACK0 = 0;
	__A0_MEM = 0;
	__A1_MEM = 0;
	__A8_MEM = 0;
	__A9_MEM = 0;

	.comment	0 : { *(.comment) }
	.callinfo	0 : { *(.callinfo) }
	.debug_abbrev	0 : { *(.debug_abbrev) }
	.debug_aranges	0 : { *(.debug_aranges) }
	.debug_frame	0 : { *(.debug_frame) }
	.debug_info	0 : { *(.debug_info) }
	.debug_line	0 : { *(.debug_line) }
	.debug_loc	0 : { *(.debug_loc) }
	.debug_macro	0 : { *(.debug_macro) }
	.debug_ranges	0 : { *(.debug_ranges) }
	.debug_rnglists	0 : { *(.debug_rnglists) }
	.debug_str	0 : { *(.debug_str) }
}
