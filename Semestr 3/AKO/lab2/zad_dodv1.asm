.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC								; (dwa znaki podkreślenia)
extern __read : PROC								; (dwa znaki podkreślenia)
public _main

.data

tekst_pocz		db 10, 'Proszę napisać jakiś tekst '
				db	'i nacisnac Enter', 10
koniec_t		db ?
magazyn			db 9 dup (?)
nowa_linia		db 10
liczba_znakow	dd ?
tekst_jaki_znak		db 10, 'Prosze podac szukany znak '
					db 'i nacisnac Enter', 10
koniec_tjz		db ?
znak_szukany	db ?
tekst_odkad_szukac db 10, 'Prosze podac od ktorego indeksu szukac i nacisnac Enter', 10
koniec_tos	db ?
odkad_szukac	db ?
tekst_nie_znaleziono db 10, '-1', 10
lokacja db '1'
koniec_lok db ?
.code

_main PROC
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

 cmp dl, 0A5h ; ą
 je minus1
 cmp dl, 0a9h ; ę
 je minus1
 cmp dl, 0e4h ; ń
 je minus1
 cmp dl, 98h ; ś
 je minus1
 cmp dl, 0beh ; ż
 je minus1
 cmp dl, 0a2h ; ó
 je duzeO
 cmp dl, 88h ; ł
 je duzeL
 cmp dl, 86h ; ć
 je duzeC
 cmp dl, 0abh ;ź 
 je duzeZi
 

 cmp dl, 'a'
 jb dalej											; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja dalej
 
 sub dl, 20H										; zamiana na wielkie litery
 jmp dalej

minus1:
	sub dl, 1
	jmp dalej
duzeO:
	add dl, 62
	jmp dalej
duzeL:
	add dl, 21
	jmp dalej
duzeC:
	add dl, 9
	jmp dalej
duzeZi:
	sub dl, 30
	jmp dalej

 

dalej:
 mov magazyn[ebx], dl
 inc ebx										; inkrementacja indeksu
 loop ptl											; sterowanie pętlą
 


 ;WPROWADZENIE SZUKANEJ LITERY
 mov ecx,(OFFSET koniec_tjz) - (OFFSET tekst_jaki_znak)
 push ecx
 push OFFSET tekst_jaki_znak								; adres tekstu
 push 1												; nr urządzenia (tu: ekran - nr 1)
 call __write										; wyświetlenie tekstu początkowego
 add esp, 12										; usuniecie parametrów ze stosu
													; czytanie wiersza z klawiatury
 push 2										; maksymalna liczba znaków ;ma być 1, ale liczy też enter, więc 2 
 push OFFSET znak_szukany
 push 0												; nr urządzenia (tu: klawiatura - nr 0)
 call __read										; czytanie znaków z klawiatury
 add esp, 12										; usuniecie parametrów ze stosu
													; kody ASCII napisanego tekstu zostały wprowadzone
													; do obszaru 'magazyn'
													; funkcja read wpisuje do rejestru EAX liczbę
													; wprowadzonych znaków
;ZAMIANA ZNAKU NA WIELKĄ LITERĘ
 mov dl, znak_szukany						; pobranie kolejnego znaku
 											; skok, gdy znak nie wymaga zamiany

 cmp dl, 0A5h ; ą
 je minus1_2
 cmp dl, 0a9h ; ę
 je minus1_2
 cmp dl, 0e4h ; ń
 je minus1_2
 cmp dl, 98h ; ś
 je minus1_2
 cmp dl, 0beh ; ż
 je minus1_2
 cmp dl, 0a2h ; ó
 je duzeO_2
 cmp dl, 88h ; ł
 je duzeL_2
 cmp dl, 86h ; ć
 je duzeC_2
 cmp dl, 0abh ;ź 
 je duzeZi_2
 

 cmp dl, 'a'
 jb indeks											; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja indeks
 
 sub dl, 20H										; zamiana na wielkie litery
 jmp indeks

minus1_2:
	sub dl, 1
	jmp indeks
duzeO_2:
	add dl, 62
	jmp indeks
duzeL_2:
	add dl, 21
	jmp indeks
duzeC_2:
	add dl, 9
	jmp indeks
duzeZi_2:
	sub dl, 30
	jmp indeks
 
 indeks:
 mov znak_szukany, dl

;WPROWADZENIE INDEKSU OD KTÓREGO PROGRAM MA ZACZĄĆ WYSZUKIWANIE
mov ecx,(OFFSET koniec_tos) - (OFFSET tekst_odkad_szukac)
 push ecx
 push OFFSET tekst_odkad_szukac								; adres tekstu
 push 1												; nr urządzenia (tu: ekran - nr 1)
 call __write										; wyświetlenie tekstu początkowego
 add esp, 12										; usuniecie parametrów ze stosu
													; czytanie wiersza z klawiatury
 push 2										; maksymalna liczba znaków ;ma być 1, ale liczy też enter, więc 2
 push OFFSET odkad_szukac
 push 0												; nr urządzenia (tu: klawiatura - nr 0)
 call __read										; czytanie znaków z klawiatury
 add esp, 12										; usuniecie parametrów ze stosu
													; kody ASCII napisanego tekstu zostały wprowadzone
													; do obszaru 'magazyn'
													; funkcja read wpisuje do rejestru EAX liczbę
													; wprowadzonych znaków
	
mov ecx, liczba_znakow
sub odkad_szukac, 30h
mov ebx, 0
mov bl, [odkad_szukac]
sub ecx, dword ptr odkad_szukac

;sub eax, 30h
ptl2: 
	mov dl, magazyn[ebx]							; pobranie kolejnego znaku
	
	cmp dl, znak_szukany							; jeśli jest to szukany znak
	je zakoncz_OK
	jmp dalej2


dalej2:
	mov magazyn[ebx], dl
	cmp ebx, liczba_znakow
	je zakoncz_nie_ok
	inc ebx										; inkrementacja indeksu
	;inc lokacja
	loop ptl2	

zakoncz_nie_ok:
	push 4
	push OFFSET tekst_nie_znaleziono
	push 1
	call __write										; wyświetlenie przekształconego tekstu
	add esp, 12	
	jmp koniec	

zakoncz_OK:
	add ebx, 30h
	mov lokacja, bl
	push 1
	push OFFSET lokacja								; adres tekstu
	push 1												; nr urządzenia (tu: ekran - nr 1)
	call __write										; wyświetlenie tekstu początkowego
	add esp, 12										; usuniecie parametrów ze stosu
	jmp koniec
 


 
 koniec:
 push 0
 call _ExitProcess@4									; zakończenie programu
_main ENDP
END