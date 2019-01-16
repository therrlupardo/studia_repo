#include <stdio.h>
extern float srednia_harm(float * tablica, unsigned int n);

int main() {
	
	float tablica[4] = { 2.0,2.0,2.0,2.0 };

	printf("Średnia harmoniczna tych liczb to: %f" ,srednia_harm(tablica, 4));

	return 0;
}