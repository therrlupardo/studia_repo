#include <stdio.h>
extern float float_razy_float(float, float);

int main()
{	
	float a = -10.0;
	float b = -10.0;
	int notcorrect = 0;
	int attempts = 0;
	while (a <= 10.0f) {
		while (b <= 10.0f) {
			attempts++;
			if (a*b != float_razy_float(a, b) && a*b != 0) {
				printf("%f * %f = %f != %f\n", a, b, a*b, float_razy_float(a, b));
				notcorrect++;
			}
			b = b + 0.5f;
		}
		b = -5.0f;
		a = a + 0.5f;
	}
	printf("Niepoprawnych mnozen: %d/%d\n", notcorrect, attempts);
	
	return 0;
}
