#include <stdio.h>
extern float srednia_kw(float * tablica, unsigned int n);

int main() {

	float tablica[4] = { 1.0,2.0,3.0,2.0 };

	printf("Srednia kwadratowa tych liczb to: %f", srednia_kw(tablica, 4));

	return 0;
}