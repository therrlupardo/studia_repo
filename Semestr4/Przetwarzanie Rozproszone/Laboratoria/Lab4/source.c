#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

int main(int argc, char* argv[]) {
	if (argv[1] == NULL) {
		Sleep(15000);
		return 0;
	}

	int children = atoi(argv[1]);

	char str[1024];
	int index = 0;
	index += sprintf(&str[index], "%s ", argv[0]);
	for (int j = 2; j < argc; j++) {
		index += sprintf(&str[index], "%d ", atoi(argv[j]));
	}

	PROCESS_INFORMATION pi;
	STARTUPINFO si;
	HANDLE* handlers = malloc(sizeof(HANDLE) * children);

	ZeroMemory(&pi, sizeof(pi));
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);

	for (int i = 0; i < children; i++) {
		CreateProcess(argv[0],
			str,
			NULL,
			NULL,
			FALSE,
			0,
			NULL,
			NULL,
			&si,
			&pi);
		WaitForSingleObject(pi.hProcess, 1000);
		handlers[i] = pi.hProcess;
	}

	Sleep(15000);
	
	for (int i = 0; i < children; i++){	
		TerminateProcess(handlers[i], 0);
	}

	free(handlers);
	return 0;
}