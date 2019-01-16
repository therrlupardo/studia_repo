#include <stdio.h>
extern int* kopia_tablicy(int[], unsigned int);

int main() {
	
	int tablica[9] = { 1,2,3,4,5,6,7,8,9 };
	int* kopia = kopia_tablicy(tablica, 9);
	for (int i = 0; i < 9; i++) printf("%d ", kopia[i]);
	return 0;
}