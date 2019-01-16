.686
.model flat
extern _malloc : PROC
public _XYZ2R

.code
; float* XYZ2R(float* tablicaXYZ, int n);
_XYZ2R PROC				
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ecx, [ebp+12]			; ilość (x,y,z) w tablicy (1/3 rozmiaru)
mov esi, [ebp+8]			; tablica


finit
sub esp, 4
push ecx
fild dword ptr [esp]		; st(0) = n
add esp, 4
push dword ptr 4
fild dword ptr [esp]
add esp, 4
fmul
fistp dword ptr [esp]
mov ecx, [esp]
add esp, 4

push ecx
call _malloc
add esp, 4
mov ecx, [ebp+12]
mov edi, eax				; kopia adresu zalokowanej pamięci

cmp eax, 0
je koniec					; malloc zwróci 0 jeśli nie zalokuje pamięci -> XYZ2R() też zwróci 0

finit
ptl:
; wczytaj 3.063 na stos koprocesora
mov edx, 3063
push edx
fild dword ptr [esp]		; st(0) = 3063
add esp, 4

mov edx, 1000
push edx
fild dword ptr [esp]		; st(0) = 1000, st(1) = 3063
add esp, 4
fdiv						; st(0) = 3.063


mov edx, [esi]				; edx = x
push edx
fld dword ptr [esp]			; st(0) = x, st(1) = 3.063
add esp, 4

fmul						; st(0) = 3.063x

; wczytaj 1.393 na stos koprocesora
mov edx, 1393
push edx
fild dword ptr [esp]		; st(0) = 1393, st(1) = 3.063x
add esp, 4

mov edx, 1000
push edx
fild dword ptr [esp]		; st(0) = 1000, st(1) = 1393, st(2) = 3.063x
add esp, 4
fdiv						; st(0) = 1.393, st(1) = 3.063x 


mov edx, [esi+4]			; edx = y
push edx
fld dword ptr [esp]			; st(0) = y, st(1) = 1.393, st(2) = 3.063x
add esp, 4

fmul						; st(0) = 1.393y, st(1) = 3.063x
fsub						; st(0) = 3.063x - 1.393y

; wczytaj 0.476 na stos koprocesora
mov edx, 476
push edx
fild dword ptr [esp]		; st(0) = 476, st(1) = 3.063x-1.393y
add esp, 4

mov edx, 1000
push edx
fild dword ptr [esp]		; st(0) = 1000, st(1) = 476, st(2) = 3.063x-1.393y
add esp, 4
fdiv						; st(0) = 0.476, st(1) = 3.063x-1.393y


mov edx, [esi+8]			; edx = z
push edx
fld dword ptr [esp]			; st(0) = z, st(1) = 0.476, st(2) = 3.063x-1.393y
add esp, 4

fmul						; st(0) = 0.476z, st(1) = 3.063x-1.393y
fsub						; st(0) = 3.063x-1.393y-0.476z

fstp dword ptr [edi]
add edi, 4
add esi, 12
loop ptl


koniec:
pop esi
pop edi
pop ebx
pop ebp
ret
_XYZ2R ENDP

 END