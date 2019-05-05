#include <pthread.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#define THREADS 8

int *primes;
int counter = 0;
pthread_mutex_t mutex;

void *prime(int _n)
{
	bool isPrime = true;

	if (_n == 0 || _n == 1)
	{
		return 0;
	}

	for (int __i = 2; __i * __i <= _n; __i++)
	{
		if (_n % __i == 0)
		{
			isPrime = false;
			break;
		}
	}

	if (isPrime == true)
	{
		pthread_mutex_lock(&mutex);
		primes[counter] = _n;
		counter++;
		pthread_mutex_unlock(&mutex);
	}
	return 0;
}

void bubbleSort(int *array, const int length)
{
	for (int __i = 0; __i < length; __i++)
	{
		for (int __j = __i + 1; __j < length; __j++)
		{
			if (array[__i] > array[__j])
			{
				int tmp = array[__j];
				array[__j] = array[__i];
				array[__i] = tmp;
			}
		}
	}
}

int main()
{
	int min;
	int max;
	int threadsCreated = 0;
	pthread_mutex_init(&mutex, NULL);
	pthread_t threads[THREADS];

	printf("Podaj poczatek zakresu:\n");
	scanf("%d", &min);
	printf("Podaj koniec zakresu:\n");
	scanf("%d", &max);

	if (min > max || min < 0 || max < 0)
	{
		printf("Invalid input. Rerun and try again!\n");
		return 1;
	}

	primes = malloc(sizeof(int) * (max - min));

	for (int __i = min; __i <= max; __i++)
	{

		int tmp = (__i - min) % THREADS;

		pthread_create(&threads[tmp], NULL, prime, __i);
		threadsCreated++;

		if (threadsCreated == THREADS)
		{
			for (int __j = 0; __j < THREADS; __j++)
			{
				pthread_join(threads[__j], NULL);
			}
			threadsCreated = 0;
		}
	}

	if (threadsCreated != 0)
	{
		for (int __j = 0; __j < threadsCreated; __j++)
		{
			pthread_join(threads[__j], NULL);
		}
	}

	if (counter != 0)
	{
		printf("Primes:\n");
		for (int __i = 0; __i < counter; __i++)
		{
			printf("%d ", primes[__i]);
		}
		printf("\n");
	}

	printf("Found %d prime number(s) in range(%d, %d).\n", counter, min, max);

	if (counter != 0)
	{
		bubbleSort(primes, counter);
		printf("Primes sorted:\n");
		for (int __i = 0; __i < counter; __i++)
		{
			printf("%d ", primes[__i]);
		}
		printf("\n");
	}
	return 0;
}