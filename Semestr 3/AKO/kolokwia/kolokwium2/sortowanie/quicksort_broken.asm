; NIE MA ŻADNEJ GWARANCJI ŻE ZADANIE DZIAŁA - BEZ DZIEL_TABLICĘ() NIE MOŻNA SPRAWDZIĆ!
.686
.model flat
public _sortuj
extern _dzielTablice : PROC		; założenie zadania -> taka funkcja istnieje
								; int dzielTablice(double* tablica, int l, int r);
								; wybiera element z tablicy, wrzuca wszystkie liczby mniejsze od niego na lewo od niego
								; a większe lub równe na prawo od niego. Zwraca indeks tego elementu po podziale.

.code

; double sortuj(int, double*)

_sortuj PROC
push ebp
mov ebp, esp
push ebx
push edi
push edi

mov ecx, [ebp+8]
mov esi, [ebp+12]

push ecx
push dword ptr 1
push esi
call _quicksort
add esp, 12

mov ecx, [ebp+8]
dec ecx
ptl:
	add esi, 8
	mov eax, [esi]
	mov edx, [esi+4]
	loop ptl

finit
push edx
push eax
fld qword ptr [esp]
add esp, 8

pop esi
pop edi
pop ebx
pop ebp
ret

_sortuj ENDP

_quicksort PROC			; void quicksort(double* tablica, int l, int r);
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov edi, [ebp+16]		; r
mov esi, [ebp+12]		; l
mov ebx, [ebp+8]		; tablica

cmp esi, edi
jge koniec

push edi
push esi
push ebx
call _dzielTablice
add esp, 12
; eax = i

dec eax					; eax = i - 1
push eax
push esi
push ebx
call _quicksort
add esp, 12

add eax, 2				; eax = i + 1
push edi
push eax
push ebx
call _quicksort
add esp, 12

koniec:
pop esi
pop edi
pop ebx
pop ebp
ret
_quicksort ENDP

 END