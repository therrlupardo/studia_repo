#include <stdio.h>
extern double sortuj(int, double*);

int main()
{	
	double array[] = { 1.0f, 20.0f, 14.54f, 21.37f };
	printf("%f", sortuj(4, array));
	
	return 0;
}
