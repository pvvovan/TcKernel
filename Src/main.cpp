__attribute__((section(".zdata"))) volatile int myvar = 1;
__attribute__((section(".zbss"))) volatile int myzero;
__attribute__((section(".zrodata"))) volatile int const ddx = 2;

__attribute__((section(".sdata"))) volatile long A0example = 20;
__attribute__((section(".sbss"))) volatile long A0example2;

long getval()
{
	volatile long v = 1;
	volatile long *p = &v;
	*p += 1;
	*p += 2;
	A0example += 16;
	return *p + A0example;
}

volatile int myval = getval();

extern "C" int core0_main();

int core0_main()
{
	for ( ; ; ) {
		myvar += ddx;
		myval += myvar + getval();
		A0example2 += 1;
		myzero += 1;
	}
	return 0;
}
