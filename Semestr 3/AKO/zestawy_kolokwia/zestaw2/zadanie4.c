#include <stdio.h>
#include <stdlib.h>
extern int* szukaj_elem_min(int[], int);

int main() {
	
	int pomiary[7] = { -3,2,5,1,6,7,4 };
	int* wsk;
	wsk = szukaj_elem_min(pomiary, 7);
	printf("\nElement minimalny: %d", wsk);


	return 0;
}