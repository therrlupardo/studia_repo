.686
.model flat
extern _malloc : PROC
public _komunikat

.data

komunikat db 'Błąd.', 0

.code

;char* komunikat(char*);
_komunikat PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi
; standard C
; ebp + 8  = adres pierwszego elementu tablicy
; ebp + 4  = adres powrotu (CALL)
; ebp

mov esi, [ebp+8]
; ile elementów ma tekst?
mov ecx, 0		; iterator
licz_znaki:
	mov eax, [esi]
	cmp eax, 0
	je koniec_liczenia
	inc esi
	inc ecx
	jmp licz_znaki
koniec_liczenia:
add ecx, 5

push ecx
call _malloc
pop ecx
sub ecx, 5
; w eax adres wyjściowy

mov edi, eax
mov esi, [ebp+8]

wpisuj:
	mov dl, [esi] 
	mov [edi], dl
	inc esi
	inc edi
	loop wpisuj
mov ecx, 0
push eax
mov eax, offset komunikat
wpisz_komunikat:
	mov dl, [komunikat+ecx]
	mov [edi], dl
	inc edi
	inc ecx
	cmp ecx, 6
	jb wpisz_komunikat
pop eax
pop edi
pop esi
pop ebx
pop ebp
ret
_komunikat ENDP
END