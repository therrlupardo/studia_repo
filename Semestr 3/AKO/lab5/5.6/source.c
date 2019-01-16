#include <stdio.h>
void dodawanie_SSE(float *);
int main()
{
	float r[4];
	dodawanie_SSE(r);
	printf("%f %f %f %f", r[0], r[1], r[2], r[3]);
	return 0;
}