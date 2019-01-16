.686
.model flat
public _suma_kwadratow_szeregu

.code

;float _suma_kwadratow_szeregu(int n);
_suma_kwadratow_szeregu PROC
push ebp
mov ebp, esp
push ebx

;stos: (standard C -> od prawej do lewej argumenty na stos)
;ebp+12 = n
;ebp+8  = adres tablicy
;ebp+4  = call
;ebp

mov ecx, [ebp+8]				; w ebx liczba

finit
fldz							; st(0) = 0 - suma kwadratow
fld1							; st(0) = 1 [dodawany element], st(0) = suma
wczytaj_kolejna:				; wczytuje liczbę, podnosi do kwadratu i dodaje do sumy
	fld st(0)					; st(0) = st(1) = dodawany element, st(2) = suma
	fmul st(0), st(0)			; st(0) = st(0) ^ 2, st(1) = dodawany element, st(2) = suma
	fadd st(2), st(0)			; st(2) = st(0) + st(2) ; stos kopr. : st(0) = dodawana liczba, st(1) = suma
	fstp st(0)					; niewiadomo dlaczego faddp linię wyżej wyrzuca dane do st(7) zamiast dać pop
	fld1						; st(0) = 1, st(1) = dodawana liczba, st(2) = suma
	faddp st(1), st(0)			; st(1) = st(0) + st(1) ; stos kopr: st(0) = dodawana liczba, st(1) = suma
	loop wczytaj_kolejna
; st(0) = dodana liczba, st(1) = suma kwadratow
fstp st(0)						; st(0) = suma kwadratów liczb

pop ebx
pop ebp
ret
_suma_kwadratow_szeregu ENDP
END