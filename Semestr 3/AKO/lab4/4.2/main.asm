.686
.model flat
public _liczba_przeciwna
.code
_liczba_przeciwna PROC
	push ebp ; zapisanie zawartości EBP na stosie
	mov ebp,esp ; kopiowanie zawartości ESP do EBP
	push ebx ; przechowanie zawartości rejestru EBX
	
; wpisanie do rejestru EBX adresu zmiennej zdefiniowanej w kodzie w języku C
	mov ebx, [ebp+8]
	neg dword PTR [ebx] ;zanegowanie liczby z kodu w C

	pop ebx
	pop ebp
	ret
_liczba_przeciwna ENDP
 END 
