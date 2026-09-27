__attribute__((section(".zdata"))) volatile int myvar = 1;
__attribute__((section(".zrodata"))) volatile int const ddx = 2;

long getval()
{
	volatile long v = 1;
	volatile long *p = &v;
	*p += 1;
	*p += 2;
	return *p;
}

volatile int myval = getval();

int main()
{
	for ( ; ; ) {
		myvar += ddx;
		myval += myvar + getval();
	}
	return 0;
}
