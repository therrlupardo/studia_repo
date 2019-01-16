#include <stdio.h>
extern void pole_kola(float*);

int main() {
	float k;
	printf("Prosze podac promien kola: ");
	scanf_s("%f", &k);
	pole_kola(&k);
	printf("Pole kola wynosi: %f", k);
 	return 0;
}