; program przykładowy (wersja 32-bitowa)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
public _main
.data


.code
_main PROC
;jakaś losowa liczba
mov eax, 0FF13ABCDh ;1111 1111 0001 0011 1010 1011 1100 1101 -> 21 jedynek
mov ecx, 0;licznik
mov edx, 32 ;ilość bitów eax
ptl:
	rcl eax, 1 ;przekręcamy eax w lewo o 1, najstarszy bit ląduje w cf
	adc cl, 0 ;cl = cl + 0 + CF
	dec edx   ;edx--
	jnz ptl	  ;edx != 0 => iteruj dalej

;mamy liczbę 1, więc liczba 0 to 32-otrzymana_liczba
mov ch, 32
sub ch, cl
mov cl, ch
push dword PTR 0 ; kod powrotu programu
call _ExitProcess@4
_main ENDP
END