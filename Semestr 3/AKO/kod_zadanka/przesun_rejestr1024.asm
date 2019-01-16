													; wczytywanie i wyświetlanie tekstu wielkimi literami
													; (inne znaki się nie zmieniają)
.686
.model flat
extern _ExitProcess@4 : PROC
public _main

.data

rejestr1024 db 80h, 127 dup (0)
endR db 'n'
.code

_main PROC

mov ecx, 128 ;ilość bajtów w rejestr1024
mov eax, 0 ;czyszczenie eax
mov al, byte ptr [rejestr1024];zapis adresu pierwszego bajtu rejestru
cmp al, 80h ;czy zaczyna się od 1
jae jeden ;jeśli ustaw cf 1
clc ;jeśli mniejsze od 80h to na pierwszym miejscu nie ma 1, więc cf = 0
jmp ptl ;skocz do przesuwania
jeden:
stc ;jeśli na pierwszym miejscu jest 1 (>=80h), to cf = 1
 
ptl:
	dec ecx ;przesuń na kolejny znak
	jz koniec ;jeśli ostatni zakończ
	mov al, [rejestr1024 + ecx] ;przesuń kolejny bajt do al
	rcl al, 1 ;przesuń w lewo
	mov [rejestr1024+ecx], al ;wpisz przesuniętą liczbę do rejestru1024
	jmp ptl ;powtórz
koniec:
	;to samo co wyżej dla najstarszego bajtu
	mov al, [rejestr1024]
	rcl al, 1
	mov [rejestr1024], al


 push 0
 call _ExitProcess@4								; zakończenie programu
_main ENDP
END 