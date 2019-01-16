.686
.model flat

public _szukaj_elem_min

.code
_szukaj_elem_min PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

; stos:
; ebp + 12 = liczba elementów
; ebp + 8  = adres tablicy
; ebp + 4  = call
; ebp

mov ebx, [ebp+8]
mov ecx, [ebp+12]

mov eax, [ebx]			; w eax minimum
sub ecx, 2
add ebx, 4
ptl:
	mov edx, [ebx]
	cmp edx, eax
	jl zmien_min
	add ebx, 4
	loop ptl
	jmp koniec
zmien_min:
	mov eax, edx
	add ebx, 4
	loop ptl

koniec:
pop edi
pop esi
pop ebx
pop ebp
ret
_szukaj_elem_min ENDP
END