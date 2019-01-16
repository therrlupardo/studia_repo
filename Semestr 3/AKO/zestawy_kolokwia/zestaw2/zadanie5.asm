.686
.model flat

public _szyfruj

.code
_szyfruj PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

; stos:
; ebp + 8  = adres tablicy
; ebp + 4  = call
; ebp

mov esi, [ebp+8]
mov ebx, 52525252H
mov eax, 0
szyfruj:
	mov al, [esi]
	cmp al, 0			; jeśli koniec tekstu zakończ szyfrowanie
	je koniec
	xor al, bl			; zaszyfruj znak
	mov [esi], al		; umieść znak w pamięci
	; zmiana liczby losowej
	bt ebx, 30
	jc jeden			; na 30 miejscu liczby losowej 1
	bt ebx, 31			
	jc wstaw_jeden		; ebx[30] = 0, ebx[31] = 1
	; ebx[30] = 0, ebx[31] = 0
	wstaw_zero:
		clc
		rcl ebx, 1
		jmp szyfruj_dalej
	jeden:
	bt ebx, 31
	jnc wstaw_zero
	wstaw_jeden:
		stc
		rcl ebx, 1
		jmp szyfruj_dalej
szyfruj_dalej:
	inc esi
	jmp szyfruj


koniec:
pop edi
pop esi
pop ebx
pop ebp
ret
_szyfruj ENDP
END