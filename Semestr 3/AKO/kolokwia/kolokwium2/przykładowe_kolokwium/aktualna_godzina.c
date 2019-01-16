#include <stdio.h>
extern void aktualna_godzina(char*);
int main()
{	
	
	char time[10];
	aktualna_godzina(time);
	printf("%s", time);
	return 0;
}
