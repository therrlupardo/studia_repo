.686
.model flat
public _float2miesz

.code
_float2miesz PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov esi, [ebp+8]
mov eax, [esi]
mov ecx, eax

shl ecx, 1
shr ecx, 24
sub ecx, 127

shl eax, 9
mov edx, 1

cmp ecx, 0
jl w_prawo
w_lewo:
	shl eax, 1
	rcl edx, 1
	loop w_lewo
jmp koniec
w_prawo:
	neg ecx
	ptl:
		shr edx, 1
		rcr eax, 1
		loop ptl

koniec:
pop esi
pop edi
pop ebx
pop ebp
ret
_float2miesz ENDP

 END