; program przykładowy (wersja 32-bitowa)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
public _main
.data

liczba db 10011011b, 11110000b, 11110011b, 11001101b


.code
_main PROC
;zmienne potrzebne do sprawdzenia działania
mov cl, 4
mov esi, OFFSET liczba
mov eax, 0
mov al, 11011110b
mov ebx, 0


mov bh, byte ptr [esi]
mov bl, byte ptr [esi+1] ;wrzucamy też kolejną jakby cl kazało nam pobrać z niej bity


shl bx, cl ;przesuwamy o cl bitów w lewo, pierwsze 3 bity będą tymi które chcemy wyjąć
shr bx, 5 ;bx = 0000 0xxx, gdzie x to bity, które chcemy wyciągnąć
;pozbywamy się 3 ostatnich bitów z al
shr al, 3
shl al, 3
;wrzucamy 3 ostatnie bity z bh do al (bez zmiany pozostałych w al)
xor al, bh


push dword PTR 0 ; kod powrotu programu
call _ExitProcess@4
_main ENDP
END