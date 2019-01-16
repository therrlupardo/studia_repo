.686
.model flat
public _miesz2float
.data

miesz32 dd 00100000000000000000001111000000b
;		   00000000100000000000001111000000 = 2097155.75
;          000000000000000000000010 0100 0000b = 2.25
;		   00000000000000000000001111000000b = 3.75
;          00000000000000011100001111000000b = (115648 u2) = 451.75

.code

_miesz2float PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov eax, [ebp+8]
mov edx, 23
mov ecx, -8

ptl:
	bt eax, 31
	jc dalej
	shl eax, 1
	dec edx
	inc ecx
	jmp ptl
dalej:		
mov eax, [ebp+8]
shl eax, cl	
btr eax, 23

add edx, 127
shl edx, 23
or eax, edx

finit
push eax
fld dword ptr [esp]
add esp, 4

pop esi
pop edi
pop ebx
pop ebp
ret
_miesz2float ENDP
END