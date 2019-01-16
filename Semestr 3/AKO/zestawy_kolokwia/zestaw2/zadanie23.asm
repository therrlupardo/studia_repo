.686
.model flat
public _ASCII_na_UTF16
extern _malloc : PROC
.data

.code

; wchar_t* ASCII_na_UTF16(char*, int)
_ASCII_na_UTF16 PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov esi, [ebp+8]		; tablica char
mov eax, [ebp+12]		; ilość elementów tablicy

; zarezerować 2*ecx bajtów na stosie
mov edx, 0
mov ebx, 2
mul ebx
push eax
call _malloc
add esp, 4
mov edi, eax			; w edi adres zalokowanej pamięci

; dla jasności w pamięci umieszczę same 0 ( później przyda się podczas wypełniania utf16, będzie już 0 na końcu)
mov ecx, [ebp+12]
ptl:
	mov [edi], byte ptr 0
	mov [edi+1], byte ptr 0
	add edi, 2
	loop ptl

mov edi, eax
mov ecx, [ebp+12]
wczytaj:
	mov bl, [esi]
	mov [edi], bl
	inc esi
	add edi, 2
	loop wczytaj

pop esi
pop edi
pop ebx
pop ebp
ret

_ASCII_na_UTF16 ENDP

 END