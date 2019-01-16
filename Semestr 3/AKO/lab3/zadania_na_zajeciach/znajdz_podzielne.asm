													; wczytywanie i wyświetlanie tekstu wielkimi literami
													; (inne znaki się nie zmieniają)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main

.data

obszar db 12 dup (?)
znaki db 12 dup (?)
dziesiec dd 10 ;mnożnik
tablica dd 6 dup (?)
;blokada db 10 dup (?)
not_found_text  db '-1',10
.code

wyswietl_EAX PROC
	pusha
mov esi, 10 ; indeks w tablicy 'znaki'
 mov ebx, 10 ; dzielnik równy 10
konwersja:
 mov edx, 0 ; zerowanie starszej części dzielnej
 div ebx ; dzielenie przez 10, reszta w EDX,
; iloraz w EAX
 add dl, 30H ; zamiana reszty z dzielenia na kod
; ASCII
 mov znaki [esi], dl; zapisanie cyfry w kodzie ASCII
 dec esi ; zmniejszenie indeksu
 cmp eax, 0 ; sprawdzenie czy iloraz = 0
 jne konwersja ; skok, gdy iloraz niezerowy
; wypełnienie pozostałych bajtów spacjami i wpisanie
; znaków nowego wiersza
wypeln:
 or esi, esi
 jz wyswietl ; skok, gdy ESI = 0
 mov byte PTR znaki [esi], 20H ; kod spacji
 dec esi ; zmniejszenie indeksu
 jmp wypeln

wyswietl:
 mov byte PTR znaki [0], 0AH ; kod nowego wiersza
 mov byte PTR znaki [11], 0AH ; kod nowego wiersza
; wyświetlenie cyfr na ekranie
 push dword PTR 12 ; liczba wyświetlanych znaków
 push dword PTR OFFSET znaki ; adres wyśw. obszaru
 push dword PTR 1; numer urządzenia (ekran ma numer 1)
 call __write ; wyświetlenie liczby na ekranie
 add esp, 12 ; usunięcie parametrów ze stosu 

	popa
	ret
wyswietl_EAX ENDP


wczytaj_do_EAX PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	push ecx
	 push dword PTR 12
	 push dword PTR OFFSET obszar ; adres obszaru pamięci
	 push dword PTR 0; numer urządzenia (0 dla klawiatury)
	 call __read ; odczytywanie znaków z klawiatury (dwa znaki podkreślenia przed read)
	 add esp, 12 ; usunięcie parametrów ze stosu bieżąca wartość przekształcanej liczby przechowywana jest w rejestrze EAX; przyjmujemy 0 jako wartość początkową
	 mov eax, 0
	 mov ebx, OFFSET obszar ; adres obszaru ze znakami
pobieraj_znaki:
	 mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie ASCII
	 inc ebx ; zwiększenie indeksu
	 cmp cl,10 ; sprawdzenie czy naciśnięto Enter
	 je byl_enter ; skok, gdy naciśnięto Enter
	 sub cl, 30H ; zamiana kodu ASCII na wartość cyfry
	 movzx ecx, cl ; przechowanie wartości cyfry w rejestrze ECX mnożenie wcześniej obliczonej wartości razy 10
	 mul dword PTR dziesiec
	 add eax, ecx ; dodanie ostatnio odczytanej cyfry
	 jmp pobieraj_znaki ; skok na początek pętli 
byl_enter:
	; wartość binarna wprowadzonej liczby znajduje się teraz w rejestrze EAX 
	pop ecx	
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
wczytaj_do_EAX ENDP

znajdz_podzielne PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
;eax [ebp+12] - dzielnik
;offset tablica [ebp+8] - tablica
;ślad [ebp+4]
;ebp
;ebx
;esi
;edi
mov esi, [ebp+8] ;w esi adres tablicy
mov ebx, [ebp+12] ;w ebx dzielnik
mov ecx, 6 ;ilość elementów do sprawdzenia
mov edi, 0;licznik podzielnych
szukaj:
mov eax, [esi]
mov edx, 0
div ebx
cmp edx, 0
je podzielna
add esi, 4
loop szukaj
jmp dalej
podzielna:
mov eax, [esi]
call wyswietl_EAX
add esi, 4
inc edi
loop szukaj

dalej:
cmp edi, 0
jne koniec
	push 3
    push OFFSET not_found_text							; adres tekstu
	push 1												; nr urządzenia (tu: ekran - nr 1)
	call __write										; wyświetlenie tekstu początkowego
	add esp, 12

koniec:
	pop edi
	pop esi
	pop ebx
	pop ebp
ret
znajdz_podzielne ENDP

_main PROC

mov ecx, 6
mov esi, offset tablica
;wczytanie tablicy liczb
wczytaj:
	call wczytaj_do_EAX
	mov [esi], ax
	add esi,4
	loop wczytaj

call wczytaj_do_EAX ;wczytanie dzielnika

push eax
push offset tablica
call znajdz_podzielne

 push 0
 call _ExitProcess@4								; zakończenie programu
_main ENDP
END x	