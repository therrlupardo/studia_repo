.686
.model flat
public _function

.data
dodatnia dd 00000000000000000000000011000000b ; 1.5 ~ 2
ujemna	 dd 11111111111111111111111111000000b ; -1.5 ~ -2
.code 

_function PROC
push ebp
mov ebp, esp
push ebx

mov edx, ujemna
bt edx, 6
jc zaokraglijWGore
zaokraglijWDol:
shr edx, 7
shl edx, 7
jmp koniec
zaokraglijWGore:
bt edx, 31
jc ujemnaWG
shr edx, 7
inc edx
shl edx, 7
jmp koniec
ujemnaWG:
shr edx, 7
dec edx
shl edx, 7

koniec:
mov edx, eax
pop ebx
pop ebp
ret
_function ENDP
END