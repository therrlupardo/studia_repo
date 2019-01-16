#include <stdio.h>
extern double ciag(unsigned int*);

double ciag2(unsigned int x)
{
	if (x == 1) return 5.0;
	if (x == 2) return 6.0;
	return (3 - ciag2(x-1)) / x;
}

int main()
{	
	int notCorrect = 0;
	int tests = 0;
	for (unsigned int i = 1; i <= 4385; i++)
	{
		tests++;
 		if(ciag2(i)!=ciag(&i))
 		{
			notCorrect++;
			printf("ciag(%u) = %f != %f\n", i, ciag2(i), ciag(&i));
 		}
	}
	printf("Znaleziono %d/%d bledow!\n", notCorrect, tests);
	return 0;
}
