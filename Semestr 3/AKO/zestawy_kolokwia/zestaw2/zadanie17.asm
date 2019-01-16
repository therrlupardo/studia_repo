.686
.model flat
public _srednia_wazona

.code

_srednia_wazona PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

; ebp+16 = adres tablicy wag float
; ebp+12 = adres tablicy liczb float
; ebp+8  = ilość elementów
; ebp+4  = call
; ebp

mov edi, [ebp+16]		; w esi tablica liczb
mov esi, [ebp+12]		; w edi tablica wag
mov ecx, [ebp+8]		; w ecx ilość elementów tablic

; średnia ważona = suma[i=1->n](waga(i)*liczba(i)) / suma[i=1->n](waga(i))
finit
fldz					; st(0) = 0 [suma waga*liczba]
fldz					; st(0) = 0 [suma wag], st(1) = suma w*l
ptl:
	; wczytaj wagę i liczbę na stos koprocesora
	mov eax, [esi]
	push eax
	fld dword ptr [esp]	; st(0) = liczba, st(1) = suma wag, st(2) = suma waga*liczba
	add esp, 4
	mov eax, [edi]
	push eax
	fld dword ptr [esp]	; st(0) = waga, st(1) = liczba, st(2) = suma wag, st(3) = suma w*l
	add esp, 4
	
	fmul st(1), st(0)	; st(0) = waga, st(1) = waga*liczba, st(2) = suma wag, st(3) = suma w*l
	faddp st(2), st(0)	; st(0) = waga*liczba, st(1) = suma wag, st(2) = suma w*l
	faddp st(2), st(0)	; st(0) = suma wag, st(1) = suma w*l
	; kolejne elementy tablic	
	add esi, 4
	add edi, 4	
	loop ptl
; st(0) = suma wag, st(1) = suma waga*liczba
fdivp st(1), st(0)
; st(0) = średnia ważona
pop esi
pop edi
pop ebx
pop ebp
ret
_srednia_wazona ENDP
END