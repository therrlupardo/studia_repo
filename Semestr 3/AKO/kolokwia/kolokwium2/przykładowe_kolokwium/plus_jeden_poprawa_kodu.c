#include <stdio.h>
extern float plus_jeden(float);
int main()
{	
	long long int notCorrect = 0;
	long long int tests = 0;
	for(float i = 1.01f; i<100.0f; i+=0.0001f)
	{
		tests++;
		if(plus_jeden(i)!=(i+1) && (plus_jeden(i) - (i + 1) > 0.000001f))
		{
			printf("%f+1=%f != %f : roznica: %f\n", i, i + 1, plus_jeden(i), (i+1)-plus_jeden(i));
			notCorrect++;
		}
	}
	printf("Znaleziono bledow: %llu/%llu\n", notCorrect, tests);
	//printf("%f", plus_jeden(2.5f));
	return 0;
}
