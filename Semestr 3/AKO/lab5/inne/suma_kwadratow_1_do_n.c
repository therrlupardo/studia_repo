#include <stdio.h>
extern float suma_kwadratow_szeregu(int n);

int main() {
	int n = 10;

	printf("Suma kwadratow tych liczb od 1 do %d: %f ",n, suma_kwadratow_szeregu(n));

	return 0;
}