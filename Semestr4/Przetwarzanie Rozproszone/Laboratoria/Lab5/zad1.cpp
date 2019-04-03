// ConsoleApplication2.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <windows.h>

int total = 0;
int textcount = 0;
int bitmapcount = 0;
int manyfilescount = 0;

using namespace std;

INT iFormat = -1;
static UINT auPriorityList[] = {
		CF_TEXT,
		CF_BITMAP,
		CF_HDROP
};

long FAR PASCAL
WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

void sendToServer(char* text)
{
	HWND hwnd = FindWindowExA(0, 0, "clipboardReceiver", 0);
	if (hwnd != 0)
	{
		COPYDATASTRUCT cd = {};
		cd.dwData = 100;
		cd.cbData = (DWORD)(strlen(text) + 1);
		cd.lpData = text;
		SendMessageA(hwnd, WM_COPYDATA, 0, (LPARAM)(&cd));
	}
}

int main()
{

	char t[500] = "ClipboardMenager";
	SetConsoleTitleA(t);
	HWND hwndConsole = FindWindowA(NULL, t);

	HINSTANCE hInstance = (HINSTANCE)GetWindowLong(hwndConsole, GWL_HINSTANCE);

	WNDCLASS wc = { 0 };
	wc.hInstance = hInstance;
	wc.lpfnWndProc = WndProc;
	wc.lpszClassName = TEXT("ClipboardMenager");

	if (!RegisterClass(&wc))
	{
		return 1;
	}

	HWND hwndWindow = CreateWindow(TEXT("ClipboardMenager"),
		TEXT(""),
		WS_MINIMIZE,
		520, 20, 1, 1,
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

long FAR PASCAL
WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	static HWND hwndNextViewer;
	HDC hdc;
	HDC hdcMem;
	PAINTSTRUCT ps;
	LPPAINTSTRUCT lpps;
	RECT rc;
	LPRECT lprc;
	HGLOBAL hglb;
	LPSTR lpstr;
	HBITMAP hbm;
	HENHMETAFILE hemf;
	HWND hwndOwner;

	switch (uMsg)
	{
	case WM_PAINT:
		hdc = BeginPaint(hwnd, &ps);
		switch (iFormat)
		{
		case CF_TEXT:
			while (!OpenClipboard(hwnd));

			hglb = GetClipboardData(iFormat);
			lpstr = (LPSTR)GlobalLock(hglb);
			cout << lpstr << endl;
			sendToServer(lpstr);
			GlobalUnlock(hglb);
			CloseClipboard();

			textcount++;
			break;
		case CF_HDROP:
			manyfilescount++;
			break;
		case CF_BITMAP:
			bitmapcount++;
			break;
		}
		total++;
		cout << "total: " << total << endl;;
		cout << "text: " << textcount << endl;;
		cout << "bitmap: " << bitmapcount << endl;;
		cout << "many files: " << manyfilescount << endl;

		EndPaint(hwnd, &ps);
		break;
	case WM_CREATE:
		hwndNextViewer = SetClipboardViewer(hwnd);
		break;
	case WM_DESTROY:
		ChangeClipboardChain(hwnd, hwndNextViewer);
		PostQuitMessage(0);
		break;
	case WM_DRAWCLIPBOARD:
		iFormat = GetPriorityClipboardFormat(auPriorityList, 4);
		InvalidateRect(hwnd, NULL, TRUE);
		UpdateWindow(hwnd);
		SendMessage(hwndNextViewer, uMsg, wParam, lParam);
		break;
	default:
		return DefWindowProc(hwnd, uMsg, wParam, lParam);
	}
	return (LRESULT)NULL;
}