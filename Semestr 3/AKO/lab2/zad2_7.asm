													; wczytywanie i wyświetlanie tekstu wielkimi literami
													; (inne znaki się nie zmieniają)
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
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
utf16_magazyn	db 160 dup (?)
tytul dw 'Z','a','d','a','n','i','e',' ','2','.','6', 0


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
 mov edx, 0
ptl: 
 mov dl, magazyn[ebx]							; pobranie kolejnego znaku
 											; skok, gdy znak nie wymaga zamiany

 cmp dl, 0A5h ; ą
 je duzeA
 cmp dl, 0a9h ; ę
 je duzeE
 cmp dl, 0e4h ; ń
 je duzeN
 cmp dl, 98h ; ś
 je duzeS
 cmp dl, 0beh ; ż
 je duzeZ
 cmp dl, 0a2h ; ó
 je duzeO
 cmp dl, 88h ; ł
 je duzeL
 cmp dl, 86h ; ć
 je duzeC
 cmp dl, 0abh ;ź 
 je duzeZi
 
 cmp dl, 0A4h ; Ą
 je duzeA
 cmp dl, 08fh ; Ć
 je duzeC
 cmp dl, 0a8h ; Ę
 je duzeE
 cmp dl, 0e3h ; Ń
 je duzeN
 cmp dl, 097h ; Ś
 je duzeS
 cmp dl, 0bdh ; Ż
 je duzeZ
 cmp dl, 0e0h ; Ó
 je duzeO
 cmp dl, 09dh ; Ł
 je duzeL
 cmp dl, 08dh ;Ź 
 je duzeZi
 

 

 cmp dl, 'a'
 jb inna_litera											; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja inna_litera
 
 sub dl, 20H										; zamiana na wielkie litery
													; odesłanie znaku do pamięci
				
 mov utf16_magazyn[2*ebx], dl  
 mov utf16_magazyn[2*ebx+1], 0h  ;
 jmp dalej

duzeA:
	mov utf16_magazyn[2*ebx], 04h
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej
duzeE:
	mov utf16_magazyn[2*ebx], 18h
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej
duzeN:
	mov utf16_magazyn[2*ebx], 43h
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej
duzeS:
	mov utf16_magazyn[2*ebx], 05Ah
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej
duzeZ:
	mov utf16_magazyn[2*ebx], 07bh
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej
duzeO:
	mov utf16_magazyn[2*ebx], 0d3h
	mov utf16_magazyn[2*ebx+1], 0h
	jmp dalej
duzeL:
	mov utf16_magazyn[2*ebx], 41h
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej
duzeC:
	mov utf16_magazyn[2*ebx], 06h
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej
duzeZi:
	mov utf16_magazyn[2*ebx], 79h
	mov utf16_magazyn[2*ebx+1], 01h
	jmp dalej

 inna_litera:
	mov utf16_magazyn[2*ebx], dl
	mov utf16_magazyn[2*ebx+1], 0h
	jmp dalej

dalej:
 inc ebx										; inkrementacja indeksu
 add edx, 2 ;indeks w utf16
 dec ecx
 jnz ptl											; sterowanie pętlą   
													; wyświetlenie przekształconego tekstu

 push 0 ; stała MB_OK
 push OFFSET tytul
 push OFFSET utf16_magazyn
 push 0 ; NULL
 call _MessageBoxW@16


 add esp, 12										; usuniecie parametrów ze stosu
 push 0
 call _ExitProcess@4								; zakończenie programu
END