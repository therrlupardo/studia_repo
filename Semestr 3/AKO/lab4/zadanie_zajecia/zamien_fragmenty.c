#include <stdio.h>
#include <stdlib.h>
extern int zamien(char*, char*, char*);

int main() {
	
	char tekst[] = "aaaxxxaaaxxxaaa";
	char do_zamiany[] = "aaa";
	char do_wpisania[] = "00"; 
	
	printf("Tekst poczatkowy: ");
	printf(tekst);
	printf("\nTekst do znalezienia: ");
	printf(do_zamiany);
	printf("\nTekst do wpisania: ");
	printf(do_wpisania);
	printf("\nPodany fragment pojawil sie %d razy.", zamien(tekst, do_zamiany, do_wpisania));
	printf("\nOtrzymano: ");
	printf(tekst);


	return 0;
}