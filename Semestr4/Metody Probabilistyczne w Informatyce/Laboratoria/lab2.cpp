#include <iostream>
#include <cmath>
#define C 1
#define N 100000
#define A 69069
using namespace std;

const long long M = pow(2, 31);

long long random(long long prev)
{
    return (A * prev + C) % M;
}

bool xor (bool a, bool b) {
    if (a == 1 && b == 0 || a == 0 && b == 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

    long long toLongLong(bool value[31])
{
    long long out = 0;
    for (int i = 0; i < 31; i++)
    {
        if (value[i] == 1)
        {
            out += pow(2, 30 - i);
        }
    }
    return out;
}

int main()
{

#pragma region 2.2
    //2.2
    cout << "2.2" << endl;
    long long value = 15;
    long long probability_array[10];
    for (int i = 0; i < 10; i++)
    {
        probability_array[i] = 0;
    }
    for (int i = 0; i < N; i++)
    {
        value = random(value);
        int index = 10 * value / M;
        probability_array[index]++;
    }
    int sum = 0;
    for (int i = 0; i < 10; i++)
    {
        sum += probability_array[i];
        cout << i << " " << probability_array[i] << endl;
    }
    cout << "Razem: " << sum << endl;
#pragma endregion

    //2.6
    cout << "2.6" << endl;
    const int p = 7;
    const int q = 3;
    long long probability_array2[10];
    for (int i = 0; i < 10; i++)
    {
        probability_array2[i] = 0;
    }
    bool value2[32] = {0, 0, 0, 0, 0,
                       0, 0, 0, 0, 0,
                       0, 0, 0, 0, 0,
                       0, 0, 0, 0, 0,
                       0, 0, 0, 0, 0,
                       1, 1, 0, 1, 0,
                       0, 1};

    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < 25; j++)
        {
            value2[j] = xor(value2[j + p], value2[j + q]);
        }
        //zamień liczbę na long long
        long long tmp = toLongLong(value2);
        //dodaj wylosowaną liczbę do tablicy
        int index = 10 * tmp / M;
        probability_array2[index]++;

        //przesuń ostatnie 7 na pierwsze 7
        for (int k = 0; k < 7; k++)
        {
            value2[25 + k] = value2[k];
        }
    }
    sum = 0;
    for (int i = 0; i < 10; i++)
    {
        sum += probability_array2[i];
        cout << i << " " << probability_array2[i] << endl;
    }
    cout << "Razem: " << sum << endl;
    return 0;
}