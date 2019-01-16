.686
.model flat
public _NWD

.code
; NWD(unsigned int a, unsigned int b);
_NWD PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

; ebp+12=b
; ebp+8=a
; ebp+4=call
; ebp

mov eax, [ebp+8]
mov ebx, [ebp+12]
cmp eax, ebx
je koniec
ja a_wieksze
b_wieksze:
	sub ebx, eax
	push ebx
	push eax
	call _NWD
	add esp, 8
	jmp koniec
a_wieksze:
	sub eax, ebx
	push ebx
	push eax
	call _NWD
	add esp, 8
koniec:
pop esi
pop edi
pop ebx
pop ebp
ret
_NWD ENDP
END