.686
.model flat
public _riemann

.code
; float riemann(int n)
_riemann PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

; ebp+8 = n
; ebp+4 = call
; ebp

mov ecx, [ebp+8]
finit

fldz			; st(0) = 0 [wynik]
ptl:
	fld1		; st(0) = 1, st(1) = wynik
	push ecx
	fild dword ptr [esp] ; st(0) = liczba, st(1) = 1, st(2) = wynik
	add esp, 4
	fmul st(0), st(0)	; st(0) - liczba ^ 2, st(1) = 1, st(2) = wynik
	fdivp st(1), st(0)	; st(0) = 1/liczba^2m st(1) = wynik
	faddp st(1), st(0)	; st(0) = wynik
	loop ptl
pop esi
pop edi
pop ebx
pop ebp
ret
_riemann ENDP
END