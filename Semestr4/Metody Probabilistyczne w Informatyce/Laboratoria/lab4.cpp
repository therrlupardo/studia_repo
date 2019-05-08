#include <iostream>
#include <time.h>

#define TO_RAND 100000

using namespace std;

int main(){
	srand(time(0));
	float fxy[4][4] = { { 0.0, 0.05, 0.1, 0.05 }, 
						{0.05, 0.1,0,0},
						{0.2,0,0.1,0.05},
						{0,0,0,0.3} };

	float fx[4] = { 0 };
	for (int i = 0; i < 4; i++){
		for (int j = 0; j < 4; j++){
			fx[j] += fxy[j][i];
		}
	}


	float Fx[4] = { 0 };
	for (int i = 0; i < 4; i++){
		for (int j = 0; j <= i; j++){
			Fx[i] += fx[j];
		}
	}
	
	float fyifx[4][4] = { { 0 }, { 0 }, { 0 }, { 0 } };
	float Fyifx[4][4] = { { 0 }, { 0 }, { 0 }, { 0 } };
	for (int i = 0; i < 4; i++){
		for (int j = 0; j < 4; j++){
			fyifx[j][i] = fxy[j][i] / fx[j];
		}
	}
	
	for (int i = 0; i < 4; i++){
		for (int j = 0; j < 4; j++){
			for (int k = 0; k <= i; k++){
				Fyifx[j][i] += fyifx[j][k];
			}
		}
	}

	int out[4][4] = { { 0 }, { 0 }, { 0 }, { 0 } };

	int it = 0;
	while (it < TO_RAND){
		float x = (float)rand() / (float)RAND_MAX;
		for (int i = 0; i < 4; i++){
			if (x < Fx[i]){
				float y = (float)rand() / (float)RAND_MAX;
				for (int j = 0; j < 4; j++){
					if (y < Fyifx[i][j]){
						out[i][j]++;
						goto next_loop;
					}
				}
			}
		}
	next_loop:
		it++;
		
	}
	for (int i = 0; i < 4; i++){
		for (int j = 0; j < 4; j++){
			cout << out[i][j] << " ";
		}
		cout << endl;
	}
	return 0;
}