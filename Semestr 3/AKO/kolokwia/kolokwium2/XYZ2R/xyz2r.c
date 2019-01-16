#include <stdio.h>
extern float * XYZ2R(float*, int);
int main()
{	
	float tablica[9] = { 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f };
	float* wynik = XYZ2R(tablica, 3);
	for(int i = 0; i < 3; i++)
	{
		printf("%f ", wynik[i]);
	}



	return 0;
}
