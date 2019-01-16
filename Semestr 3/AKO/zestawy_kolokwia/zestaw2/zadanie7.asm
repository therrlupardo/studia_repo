.686
.model flat
public _iteracja

.code 

_iteracja PROC
push ebp
mov eax, 0			; tej linii nie ma w kodzie w zadaniu, ale bez niej wyrzuca losowe wartości
mov ebp, esp
mov al, [ebp+8]
sal al, 1			; SAL wykonuje przesunięcie arytmetyczne w lewo

jc zakoncz
inc al
push eax
call _iteracja
add esp, 4
pop ebp
ret
zakoncz:
rcr al, 1			; RCR wykonuje przesunięcie cykliczne w prawo z użyciem CF
pop ebp
ret
_iteracja ENDP
END