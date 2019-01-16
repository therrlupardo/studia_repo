.686
.model flat
public _function

.data
do23   dd 1111111111111111111111100000001b 
do24_1 dd 0111111111111111111111110000001b ; większe od do23
do24_2 dd 0111111111111111111111110000000b ; mniejsze od do23
do24_3 dd 1111111111111111111111110000000b ; większe od do23
do24_4 dd 1111111111111111111111110000000b ; większe od do23
.code 

_function PROC
push ebp
mov ebp, esp
push ebx

mov esi, dword ptr do23
mov edi, dword ptr do24_1

bt edi, 31		; czy w edi jest 2^24? Jeśli jest to na pewno większe od esi
jc edi_wieksze	
shl edi, 1		
cmp edi, esi
ja edi_wieksze

esi_wieksze:
	stc
	jmp koniec
edi_wieksze:
	clc

koniec:
mov edx, eax
pop ebx
pop ebp
ret
_function ENDP
END