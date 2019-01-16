													; wczytywanie i wyświetlanie tekstu wielkimi literami
													; (inne znaki się nie zmieniają)
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __write : PROC								; (dwa znaki podkreślenia)
extern __read : PROC								; (dwa znaki podkreślenia)
public _main

.data

tekst_pocz		db 10, 'Proszę napisać jakiś tekst '
				db	'i nacisnac Enter', 10
koniec_t		db ?
magazyn			db 80 dup (?)
nowa_linia		db 10
liczba_znakow	dd ?
				;   ą	  Ą		ę	  Ę		ó	  Ó     ć	  Ć
latin2			db 0A5h, 0A4h, 0a9h, 0a8h, 0a2h, 0e0h, 86h, 08fh
				;   ń     Ń		ś	  Ś		ż    Ż	   ł	 Ł    ź		Ź
				db 0e4h, 0e3h, 98h, 097h, 0beh, 0bdh, 88h, 09dh, 0abh, 08dh 
				;	Ą	Ą	  Ę	   Ę	Ó	 Ó	  Ć    Ć	Ń	  Ń
windows1250		db 0A5h,0A5h,0cah,0cah,0d3h,0d3h,0c6h,0c6h,0d1h,0d1h
				;   Ś	Ś	  Ż	   Ż	Ł	 Ł	  Ź	   Ź
				db 08ch,08ch,0afh,0afh,0a3h,0a3h,08fh,08fh
tytul db 'Zadanie 2.6', 0


.code

_main:
													; wyświetlenie tekstu informacyjnego
													; liczba znaków tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz								; adres tekstu
 push 1												; nr urządzenia (tu: ekran - nr 1)
 call __write										; wyświetlenie tekstu początkowego
 add esp, 12										; usuniecie parametrów ze stosu
													; czytanie wiersza z klawiatury
 push 80											; maksymalna liczba znaków
 push OFFSET magazyn
 push 0												; nr urządzenia (tu: klawiatura - nr 0)
 call __read										; czytanie znaków z klawiatury
 add esp, 12										; usuniecie parametrów ze stosu
													; kody ASCII napisanego tekstu zostały wprowadzone
													; do obszaru 'magazyn'
													; funkcja read wpisuje do rejestru EAX liczbę
													; wprowadzonych znaków
 mov liczba_znakow, eax
													; rejestr ECX pełni rolę licznika obiegów pętli

 mov ecx, eax
 mov ebx, 0											; indeks początkowy

ptl: 
 mov dl, magazyn[ebx]							; pobranie kolejnego znaku

mov eax,0
szukaj:
	cmp dl, latin2[eax]
	jne szukaj_dalej
	mov dl, windows1250[eax]
    jmp dalej
szukaj_dalej:
	inc eax
	cmp eax, 18
	jbe szukaj
 

 cmp dl, 'a'
 jb dalej											; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja dalej
 
 sub dl, 20H										; zamiana na wielkie litery
													; odesłanie znaku do pamięci
 jmp dalej


dalej:
 mov magazyn[ebx], dl
 inc ebx										; inkrementacja indeksu
 dec ecx
 jnz ptl											; sterowanie pętlą
													; wyświetlenie przekształconego tekstu

 push 0 ; stała MB_OK
 push OFFSET tytul
 push OFFSET magazyn
 push 0 ; NULL
 call _MessageBoxA@16


 add esp, 12										; usuniecie parametrów ze stosu
 push 0
 call _ExitProcess@4								; zakończenie programu
END