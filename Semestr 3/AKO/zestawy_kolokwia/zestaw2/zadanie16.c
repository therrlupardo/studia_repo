#include <stdio.h>
extern double dodaj_jeden(double);

int main()
{
	int notCorrect = 0;
	int tests = 0;
	for (double i = 1.5f; i <= 10.0f; i += 0.25f) {
		tests++;
		if (i + 1 != dodaj_jeden(i)) {
			printf("%f + 1 = %f != %f\n", i, i + 1, dodaj_jeden(i));
			notCorrect++;
		}
	}
	printf("Niepoprawnych odpowiedzi: %d/%d", notCorrect, tests);

	return 0;
}