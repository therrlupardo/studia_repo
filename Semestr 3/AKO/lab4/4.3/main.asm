.686
.model flat
public _odejmij_jeden
.code
_odejmij_jeden PROC
	push ebp ; zapisanie zawartości EBP na stosie
	mov ebp,esp ; kopiowanie zawartości ESP do EBP
	push ebx ; przechowanie zawartości rejestru EBX
	push ecx
; wpisanie do rejestru EBX adresu zmiennej zdefiniowanej w kodzie w języku C
	mov ebx, [ebp+8]
	mov ecx, [ebx]
	dec dword PTR [ecx] ; liczba - 1

	pop ecx
	pop ebx
	pop ebp
	ret
_odejmij_jeden ENDP
 END 
