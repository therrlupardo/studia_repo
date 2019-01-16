.686
.model flat
public _druk_szeroki
extern __write : PROC
.code
_druk_szeroki PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ecx, [ebp+12]
mov esi, [ebp+8]

mov eax, ecx
mov edx, 0
mov ebx, 2
mul ebx				; eax = 2n

sub esp, eax
mov edi, esp
mov [edi], byte ptr 0
add edi, eax
dec edi
mov edx, edi

umiesc:
	mov bl, [esi]
	mov [edx], bl
	inc edx
	mov bl, ' '
	mov [edx], bl
	inc edx
	inc esi
	loop umiesc
dec edx
mov [edx], byte ptr 0

mov eax, [ebp+12]
mov edx, 0
mov ebx, 2
mul ebx
push eax
push edi
push dword ptr 1
call __write
add esp, 12

mov eax, [ebp+12]
mov edx, 0
mov ebx, 2
mul ebx

add esp, eax

pop esi
pop edi
pop ebx
pop ebp
ret
_druk_szeroki ENDP

 END