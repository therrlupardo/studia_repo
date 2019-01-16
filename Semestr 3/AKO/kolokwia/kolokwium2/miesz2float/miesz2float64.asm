.686
.model flat
public _miesz2float
.data

.code


; float miesz2float(MIESZ64 q)
_miesz2float PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov edx, [ebp+12]
mov eax, [ebp+8]
; EDX:EAX = q


cmp edx, 0
je szukaj_w_eax			; q < 1
mov ecx, 31
szukaj_edx:
	bt edx, ecx
	jc znaleziono_edx
	loop szukaj_edx
	; jeśli ecx=0 i jeszcze nie znaleziono 1 to edx=1
znaleziono_edx:
	push ecx
	przesun:
		shr edx, 1
		rcr eax, 1
		loop przesun
	pop ecx
shr eax, 9				; miejsce na mantyse
add ecx, 127
shl ecx, 23
or eax, ecx
jmp koniec
szukaj_w_eax:
mov ecx, 0
dec ecx					; ecx = -1
szukaj_eax:
	bt eax, 31
	jc znaleziono_eax
	shl eax, 1
	dec ecx
	jmp szukaj_eax		; pomijamy 0, więc nie będzie przypadku edx=eax=0
znaleziono_eax:
	shl eax, 1			; pozbywamy się najstarszej 1
	shr eax, 9
	add ecx, 127
	shl ecx, 23
	or eax, ecx
koniec:
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