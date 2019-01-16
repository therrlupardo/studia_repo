#include <stdio.h>
extern wchar_t* ASCII_na_UTF16(char*, int);

int main()
{	
	char tablica[] = "Zadanie 23 zostalo zrobione!";
	wchar_t* utf16 = ASCII_na_UTF16(tablica, 29);
	printf("%ls", utf16);
	
	return 0;
}
