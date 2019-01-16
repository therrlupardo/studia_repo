#include <stdio.h>
#include <stdlib.h>
extern void przestaw(int ** arraya, int n);
int main()
{
	int n;
	int* array;

	printf("\nProsze napisac liczbe: ");
	scanf_s("%d", &n, 12);

	array = malloc(n * sizeof(int));
	printf("\nProsze napisac %d liczb:", n);
	for(int i = 0; i < n; i++)
	{
		scanf_s("%d", &array[i], 12);
	}

	for (int i = n; i > 1; i--)
	//funkcja przestaw ustawia największy element na ostatnim miejscu tabeli (n).
	//zmniejszamy n, aby ustawić (n-i) element na i-tym miejscu od prawej strony
	{
		przestaw(array, i);
	}

	printf("\nPosortowane: ");
	for (int i = 0; i < n; i++)
	{
		printf("%d ", array[i]);
	}
	return 0;
}