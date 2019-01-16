.686
.model flat
public _function

.data
liczbaZero dd 00000000000000000000000001111111b
liczbaNZero dd 00000000000000000000000010000000b

.code 

_function PROC
push ebp
mov ebp, esp
push ebx

mov ebx, dword ptr liczbaZero
shr ebx, 7
cmp ebx, 0
je ustaw_jeden
clc
jmp koniec
ustaw_jeden:
stc

koniec:

pop ebx
pop ebp
ret
_function ENDP
END