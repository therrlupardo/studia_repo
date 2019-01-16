.686
.model flat
public _srednia_kw

.data

jeden dd 1.0
.code

;float srednia_kw(float * tablica, unsigned int n);
_srednia_kw PROC
push ebp
mov ebp, esp
push ebx

;stos: (standard C -> od prawej do lewej argumenty na stos)
;ebp+12 = n
;ebp+8  = adres tablicy
;ebp+4  = call
;ebp

mov ecx, [ebp+12]				; ecx = ilość elementów, potrzebne później jako iterator do średniej
mov ebx, [ebp+8]				; w ebx adres pierwszego elementu tablicy


finit
fldz							; st(0) = 0 - suma kwadratow

wczytaj_kolejna:				; wczytuje liczbę, podnosi do kwadratu i dodaje do sumy
	push real4 ptr [ebx]		; wrzuca na stos liczbę
	fld real4 ptr [ebp-8]		; st(0) = liczba, st(1) = suma
	fmul st(0), st(0)			; st(0) = st(0) ^ 2, st(1) = suma
	faddp st(1), st(0)			; st(1) = st(0) + st(1) ; stos kopr. : st(0) = suma
	add esp, 4
	add ebx, 4
	loop wczytaj_kolejna
;st(0) = suma kwadratow
push real4 ptr [ebp+12]			; wrzuca n na stos
fild dword ptr [ebp-8]			; st(0) = n, st(1) = suma kwadratow
add esp, 4						
fdivp st(1), st(0)				; st(1) = st(1)/st(0) ; stos kopr: st(0) = suma kw / ilosc elem
fsqrt							; st(0) = sqrt(st(0))

pop ebx
pop ebp
ret
_srednia_kw ENDP
END