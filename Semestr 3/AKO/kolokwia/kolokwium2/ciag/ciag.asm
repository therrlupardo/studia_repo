.686
.model flat
public _ciag

.code
_ciag PROC			; double ciag(unsigned int*)
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ecx, [ebp+8]
mov esi, [ecx]

cmp esi, 1
je zwroc5
cmp esi, 2
je zwroc6


dec esi
mov [ecx], esi
push ecx
call _ciag				; st(0) = ciag(x-1)
add esp, 4
inc esi
mov [ecx], esi


push esi
fild dword ptr [esp]	; st(0) = x, st(1) = ciag(x-1)
add esp, 4

mov edi, 3
push edi
fild dword ptr [esp]	; st(0) = 3, st(1) = x, st(2) = ciag(x-1)
add esp, 4

fsub st(0), st(2)		; st(0) = 3-ciag(x-1), st(1) = x, st(2) = ciag(x-1)
fstp st(2)				; st(0) = x, st(1) = 3-ciag(x-1)
fdivp st(1), st(0)		; st(0) = (3-ciag(x-1))/x

jmp koniec

zwroc5:
	mov edi, 5
	push edi
	fild dword ptr [esp]
	add esp, 4
	jmp koniec

zwroc6:
	mov edi, 6
	push edi
	fild dword ptr [esp]
	add esp, 4
koniec:

pop esi
pop edi
pop ebx
pop ebp
ret
_ciag ENDP

 END