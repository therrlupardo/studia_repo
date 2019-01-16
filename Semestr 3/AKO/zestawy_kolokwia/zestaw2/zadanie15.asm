.686
.model flat

public _pole_kola

.data
liczba dd 1.0

.code 

_pole_kola PROC
push ebp
mov ebp, esp
push ebx

mov esi, [ebp+8]		; esi = adres promienia
mov eax, [esi]			; eax = promień

finit 
fldpi					; st(0) = pi
push eax
fld dword ptr [esp]		; st(0) = r, st(1) = pi
add esp, 4
fmul st(0), st(0)		; st(0) = r^2, st(1) = pi
fmulp st(1), st(0)		; st(0) = pi*r^2

sub esp, 4
fstp dword ptr [esp]
mov eax, [esp]
add esp, 4
mov [esi], eax
pop ebx
pop ebp
ret
_pole_kola ENDP
END