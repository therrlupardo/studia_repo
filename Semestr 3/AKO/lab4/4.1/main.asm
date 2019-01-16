	.686
.model flat
public _szukaj4_max
.code
_szukaj4_max PROC
	push ebp ; zapisanie zawartości EBP na stosie
	mov ebp, esp ; kopiowanie zawartości ESP do EBP
	
	mov eax, [ebp+8] ; liczba a
	cmp eax, [ebp+12] ; porownanie liczb a i b
	jge a_wieksza ; skok, gdy a >= b
	
; przypadek a < b
	mov eax, [ebp+12] ; liczba b
	cmp eax, [ebp+16] ; porownanie liczb b i c
	jge b_wieksza ; skok, gdy b >= c
	
; przypadek b < c
; zatem z jest liczbą najwiekszą
	wpisz_c:
		mov eax, [ebp+16] ; liczba z
	
porownaj_d:
	cmp eax, [ebp+20]
	jge zakoncz
	mov eax, [ebp+20]

zakoncz:
	pop ebp
	ret
	
a_wieksza:
	cmp eax, [ebp+16] ; porownanie a i c
	jge zakoncz ; skok, gdy a >= c
	jmp wpisz_c
	
b_wieksza:
	mov eax, [ebp+12] ; liczba b
	jmp zakoncz

_szukaj4_max ENDP
END