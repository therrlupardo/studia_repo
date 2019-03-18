#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){
	if(argv[1] == NULL){
		return 0;
	}
printf("Function running!\n");
	int children = atoi(argv[1]);
	char** argv2 = malloc(sizeof(char*)*(argc-1));
	pid_t *children_list = malloc(sizeof(pid_t) * children);
	argv2[0] = argv[0];

	for( int i = 2; i < argc; i++){
		argv2[i-1] = argv[i];
	}
	argv2[argc-1] = NULL;

	for( int i = 0; i < children; i++){

		children_list[i] -1; // ?
		children_list[i] = fork();
		if(children_list[i] == 0){
			execv(argv[0], (char**) argv2);
			break;
		}
	}

	sleep(30);
	while(wait(NULL) > 0);
	return 0;
}