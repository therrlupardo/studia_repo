.686
.model flat
public _dodaj_jeden
.code
; double dodaj_jeden(float a);
_dodaj_jeden PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

; odczytanie liczby w formacie double
mov eax, [ebp+8]
mov edx, [ebp+12]
; wpisanie 1 na pozycji o wadze 2^0 mantysy EDI:ESI
mov esi, 0
mov edi, 00100000h
; wyodrębnienie pola wykładnika 11-bit
; bit znaku liczby z założenia = 0
mov ebx, edx
shr ebx, 20
; obliczanie pierwotengo wykładnika potęgi
sub ebx, 1023
; zerowanie wykładnika i bitu znaku
and edx, 000fffffh
; dopisanie niejawnej jedynki
or edx, 00100000h
;-------------

;-------------
; załadowanie obliczonej wartośći z EDX:EAX na wierzchołek stosu koprocesora
push edx
push eax
fld qword PTR [esp]
add esp, 8

pop esi
pop edi
pop ebx
pop ebp
ret
_dodaj_jeden ENDP
END