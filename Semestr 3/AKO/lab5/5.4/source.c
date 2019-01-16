#include <stdio.h>

void int2float(int*, float*);

int main()
{
	int a[2] = { -17, 24 };
	float r[4];
	// podany rozkaz zapisuje w pamięci od razu 128 bitów,
	// więc muszą być 4 elementy w tablicy
	int2float(a, r);
	printf("\nKonwersja = %f %f\n", r[0], r[1]);
	
	return 0;
}