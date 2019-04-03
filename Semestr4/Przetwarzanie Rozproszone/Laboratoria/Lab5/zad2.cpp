// ConsoleApplication5.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>

using namespace std;

long FAR PASCAL
WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	COPYDATASTRUCT* pcds = { 0 };
	pcds = (COPYDATASTRUCT*)lParam;
	switch (uMsg)
	{
	case WM_COPYDATA:

		if (pcds->dwData == 100)
		{
			char* lpszString = (char*)(pcds->lpData);
			cout << lpszString << endl;
		}

		break;
	default:
		return DefWindowProc(hwnd, uMsg, wParam, lParam);
	}
	return (LRESULT)NULL;

}


int main()
{
	char t[500] = "ClipboardReceiver";
	SetConsoleTitleA(t);
	HWND hwndConsole = ::FindWindowExA(0, 0, "ClipboardReceiver", 0);

	HINSTANCE hInstance = (HINSTANCE)GetWindowLong(hwndConsole, GWL_HINSTANCE);

	WNDCLASS wc = { 0 };
	wc.hInstance = hInstance;
	wc.lpfnWndProc = WndProc;
	wc.lpszClassName = TEXT("ClipboardReceiver");

	if (!RegisterClass(&wc))
	{
		return 1;
	}

	HWND hwndWindow = CreateWindow(TEXT("ClipboardReceiver"),
		TEXT(""),
		WS_MINIMIZE,
		520, 20, 100, 100,
		NULL,
		NULL,

		hInstance, NULL);

	ShowWindow(hwndWindow, SW_SHOWMINIMIZED);
	UpdateWindow(hwndWindow);

	MSG msg;
	while (GetMessage(&msg, hwndWindow, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return msg.wParam;
}