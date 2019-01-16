#include <stdio.h>
extern int druk_szeroki(char[], int);

int main()
{	
	char tablica[] = { 'A','K','O' };
	printf("\n%d", druk_szeroki(tablica, 3));
	return 0;
}
