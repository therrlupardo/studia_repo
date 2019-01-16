.686
.model flat
public _srednia_harm

.data

jeden dd 1.0
.code

;float srednia_harm(float * tablica, unsigned int n);
_srednia_harm PROC
push ebp
mov ebp, esp
push ebx

;stos: (standard C -> od prawej do lewej argumenty na stos)
;ebp+12 = n
;ebp+8  = adres tablicy
;ebp+4  = call
;ebp

mov ecx, [ebp+12]				;ecx = ilość elementów, potrzebne później jako iterator do średniej
mov ebx, [ebp+8]				; w ebx adres pierwszego elementu tablicy
mov eax, ecx

finit

;sumowanie odwrotności elementów tablicy 
fldz						; st(0) = 0 - sumator mianownika
ptl:
	push real4 ptr [ebx]
	fld real4 ptr [ebp-8]			; st(0) = a_i, st(1) = suma mianownika
	fld jeden				; st(0) = 1.0, st(1) = a_i, st(2) = suma mianownika
	fdiv st(0), st(1)			; st(0) =  st(0) / st(1), st(1) = a_i, st(2) = suma mianownika
	fadd st(2), st(0)			; st(2) = st(2) + st(0)
	fstp st(0)				; st(0) = a_i, st(1) = suma mianownika
	fstp st(0)				; st(0) = suma mianownika
	pop eax
	add ebx, 4				; kolejny element tablicy
	loop ptl
fild dword ptr [ebp+12]				; st(0) = n, st(1) = suma mianownika
fxch st(1)					; st(0) = suma mianownika, st(1) = n
fdivp st(1), st(0)				; st(1) = st(1)/st(0), stos_kopr: st(0) = wynik

pop ebx
pop ebp
ret
_srednia_harm ENDP
END
