#include <stdio.h>
extern long long float2miesz(float*);

int main()
{	
	float * q;
	float a = 12.5f;
	float b = 0.5f;
	q = &a;
	printf("53687091200=%lld\n", float2miesz(q));
	q = &b;
	printf("2147483648=%lld\n", float2miesz(q));
	return 0;
}
