#include <stdio.h>

extern float riemann(int);

int main() {
	for(int i = 1; i <= 50; i++)
		printf("riemann(%d) %f\n",i, riemann(i));
	return 0;
}