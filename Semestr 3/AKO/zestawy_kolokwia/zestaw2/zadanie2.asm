.686
.model flat
extern _malloc : PROC
public _kopia_tablicy

.code

;int* _kopia_tablicy(int[], unsigned int);
_kopia_tablicy PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi
; standard C
; ebp + 12 = liczba elementów n
; ebp + 8  = adres pierwszego elementu tablicy
; ebp + 4  = adres powrotu
; ebp

mov ecx, [ebp+12]		; w ecx ilość elementów
mov edi, [ebp+8]		; w ebx adres pierwszego elementu tablicy


; rezerwacja miejsca na nową tablicę
push ecx
call _malloc
pop ecx
cmp eax, 0
jz koniec ; jeśli malloc wyrzuci 0 (nie może zarezerwować pamięci), to funkcja zwraca 0 poprzez eax, tak samo jak malloc

; zerowanie nowej tablicy
mov esi, eax
push ecx
zeruj:
	mov [esi], dword ptr 0
	add esi, 4
	loop zeruj
pop ecx

; w eax adres nowej tablicy
mov esi, eax			; w esi adres nowej tablicy
push eax
mov ebx, 0
ptl:
	mov eax, [edi]	; wczytuje element tablicy do eax
	bt eax, 0		; CF = bit na 0'wym miejscu w eax (od prawej)
	jc kolejny		; jeśli 1 => eax nieparzyste => nie zapisuje
	mov [esi], eax	; wpisuje liczbę z eax do tablicy z esi
	add esi, 4		; przesuwa indeks w tablicy wyjściowej
kolejny:
	add edi, 4		; przesuwa indeks w tablicy wejściowej
	loop ptl

pop eax
koniec:
pop edi
pop esi
pop ebx
pop ebp
ret
_kopia_tablicy ENDP
END