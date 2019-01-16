#include <stdio.h>
extern double srednia_wazona(int, float*, float*);

int main() {
	float tablica[5] = { 5.0f,1.0f ,1.0f ,1.0f ,1.0f };
	float wagi[5] = { 3.0f,2.0f ,2.0f ,2.0f ,2.0f };
	printf("%f", srednia_wazona(5, tablica, wagi));

 	return 0;
}