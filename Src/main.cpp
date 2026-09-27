volatile int myvar __attribute__((section(".zdata"))) = 1;
volatile int const ddx __attribute__((section(".zrodata"))) = 2;

int main()
{
	for ( ; ; ) {
		myvar += ddx;
	}
	return 0;
}
