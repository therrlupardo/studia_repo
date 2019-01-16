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
 jb dalej											; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja dalej
 
 sub dl, 20H										; zamiana na wielkie litery
													; odesłanie znaku do pamięci
 jmp dalej

duzeA:
	mov dl, 0A5h
	jmp dalej
duzeE:
	mov dl, 0cah
	jmp dalej
duzeN:
	mov dl, 0d1h
	jmp dalej
duzeS:
	mov dl, 08ch
	jmp dalej
duzeZ:
	mov dl, 0afh
	jmp dalej
duzeO:
	mov dl, 0d3h
	jmp dalej
duzeL:
	mov dl, 0a3h
	jmp dalej
duzeC:
	mov dl, 0c6h
	jmp dalej
duzeZi:   
	mov dl, 08fh
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