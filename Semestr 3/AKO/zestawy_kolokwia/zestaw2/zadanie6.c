#include <stdio.h>
#include <stdlib.h>
extern unsigned int kwadrat(int);

int main() {
	for (int i = 0; i < 15; i++)
	{
		printf("Kwadrat liczby %d to %d \n", i, kwadrat(i));
	}

	return 0;
}