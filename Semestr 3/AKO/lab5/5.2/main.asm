.686
.model flat
public _nowy_exp

.data

.code

;float nowy_exp(float x);
_nowy_exp PROC
push ebp
mov ebp, esp
push ebx

;stos
;ebp+8 = x
;ebp+4 = call
;ebp

finit
fld1							; st(0) = 1 - sumator
fld dword ptr [ebp+8]					; st(0) = x, st(1) = sumator

mov ecx, 20						; iterator pętli
mov eax, 1						; ilość obrotów
mov ebx, 1						; aktualny obrót
ptl:
	fld1						; st(0) = 1 [aktualny wynik], st(1) = x, st(2) = sumator
	ptl2:
		push ebx
		fild dword ptr [ebp-8]			; st(0) = dzielnik, st(1) = aktualny wynik, st(2) = x, st(3) = sumator
		pop  ebx

		fld  st(2)				; st(0) = x, st(1) = dzielnik, st(2) = aktualny wynik, st(3) = x, st(4) = sumator
		fmul st(2), st(0)			; aktualny wynik *= x
		fstp st(0)				; st(0) = dzielnik, st(1) = aktualny wynik, st(2) = x, st(3) = sumator
		fdiv st(1), st(0)			; aktualny wynik /= dzielnik

		fstp st(0)				; st(0) = aktualny wynik, st(1) = x, st(2) = sumator

		cmp  ebx, eax			
		je   dalej
		inc  ebx
		jmp  ptl2
		dalej:
			 inc eax
			 mov ebx, 1
			 fadd st(2), st(0)		; dodaje do sumatora aktualny wynik
			 fstp st(0)			; st(0) = x, st(1) = sumator			
			 loop ptl

fstp st(0)						; st(0) = sumator

pop ebx
pop ebp
ret
_nowy_exp ENDP
END
