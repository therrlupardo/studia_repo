.686
.model flat

public _kwadrat

.code

pow PROC
	push ebp
	mov ebp, esp
	push ebx
	
	; ebp + 8 = liczba
	; ebp + 4 = call
	; ebp

	mov eax, [ebp+8]
	cmp eax, 0
	je zero
	cmp eax, 1
	je jeden
	mov ebx, 0
	mov ecx, 4
	razy4:
		add ebx, eax
		loop razy4
	; ebx = 4a-4
	sub ebx, 4
	sub eax, 2
	push eax
	call pow
	add esp, 4
	add eax, ebx
	jmp koniec
zero:
	mov eax, 0
	jmp koniec

jeden:
	mov eax, 1
	jmp koniec

koniec:
	pop ebx
	pop ebp
	ret
pow ENDP

_kwadrat PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

; stos:
; ebp + 8  = liczba
; ebp + 4  = call
; ebp

push dword ptr [ebp+8]
call pow
add esp, 4

pop edi
pop esi
pop ebx
pop ebp
ret
_kwadrat ENDP
END