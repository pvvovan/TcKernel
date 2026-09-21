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
		*(.startup)
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

	.debug :
	{
		*(.debug_*)
		*(.comment)
	}
}
