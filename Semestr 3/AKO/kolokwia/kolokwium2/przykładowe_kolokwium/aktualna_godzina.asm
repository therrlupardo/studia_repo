.686
.model flat
extern _GetSystemTime@4 : PROC
extern _malloc : PROC
public _aktualna_godzina

.code
; void aktualna_godzina(char*)
_aktualna_godzina PROC				
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov edi, [ebp+8]			; w edi adres wynikowy

mov ecx, 16
push ecx
call _malloc
add esp, 4
; w eax zarezerwowany obszar pamięci
mov ebx, eax
push ebx
call _GetSystemTime@4

mov eax, 0
mov ax, [ebx+8]

mov [edi+2], byte ptr 0

mov dx, 0
mov bx, 10
div bx
add ax, 30h
add dx, 30h
mov [edi], al
mov [edi+1], dl
mov [edi+2], byte ptr 0


koniec:
pop esi
pop edi
pop ebx
pop ebp
ret
_aktualna_godzina ENDP

 END