.686
.model flat
public _liczba_procesorow
extern _malloc : PROC
extern _GetSystemInfo@4 : PROC
.code

_liczba_procesorow PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ecx, 40
push ecx
call _malloc
add esp, 4

mov ecx, 40
mov esi, eax
ptl:
	mov [esi], dword ptr 0
	add esi, 4
	loop ptl

mov ebx, eax
push ebx
call _GetSystemInfo@4
; w eax dane systemowe

mov eax, dword ptr [ebx+20]

pop esi
pop edi
pop ebx
pop ebp
ret
_liczba_procesorow ENDP
END