#include <stdio.h>
#include <stdlib.h>
extern void szyfruj(char*);

int main() {
	
	char tekst[] = "tekst testowy ABC ABC";
	printf("%s\n", tekst);
	szyfruj(tekst);
	printf(tekst);

	return 0;
}