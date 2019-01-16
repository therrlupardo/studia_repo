#include <stdio.h>
extern unsigned __int64 sortowanie(unsigned __int64*, unsigned int);

int main()
{	

	unsigned __int64 array[5] = { 11, 5, 3, 19, 25 };

	unsigned __int64 max = sortowanie(array, 5);

	printf("array[] = {");
	for(int i = 0; i < 5; i++)
	{
		printf("%I64u", array[i]);
		if (i != 4) printf(", ");
	}
	printf("}\nmax: %I64u", max);
	
	return 0;
}
