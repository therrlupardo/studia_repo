#include <stdio.h>
extern char* komunikat(char*);

int main() {
	
	char * tekst = "Tekst testowy zadanie 3.";
	tekst = komunikat(tekst);
	printf(tekst);

	return 0;
}