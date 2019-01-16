#include <stdio.h>
extern __int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, 
	__int64	v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);

int main()
{
	__int64 suma;

	suma = suma_siedmiu_liczb(4000000, -345679, 88046592,
		-1, 2297645, 7867023, -19000444);
	//suma = suma_siedmiu_liczb(1, 1, 1, 1, 1, 1, 1);

	printf("\nSuma podanych liczb wynosi %I64d\n", suma);
	return 0;
}
