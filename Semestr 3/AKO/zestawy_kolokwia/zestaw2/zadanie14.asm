.686
.model flat

public _function

.data
liczba real4 -8.25
tu_wpisac real4 ?,?

.code 

_function PROC
push ebp
mov ebp, esp
push ebx

mov esi, real4 ptr liczba
mov edi, offset tu_wpisac

mov eax, esi
shl eax, 1
shr eax, 24
; eax = 0000 0000 0000 0000 0000 0000 xxxx xxxx, gdzie x-wykladnik

mov ebx, esi
shl ebx, 9
shr ebx, 9
; ebx = 0000 0000 0xxx xxxx xxxx xxxx xxxx xxxx, gdzie x-mantysa


sub eax, 127
add eax, 1023
; eax ma poprawny wykladnik dla double, na 11 bitach

shr esi, 31
shl esi, 11
xor esi, eax
; w esi 20 x 0 | bit znaku | 11 bitowy wykladnik
shl esi, 20
; esi = bit znaku | 11 bitowy wykladnik | 20 x 0

mov ecx, ebx ; kopia mantysy
shr ebx, 3	 ; ebx = 0000 0000 0000 xxxx xxxx xxxx xxxx xxxx , pierwsze 20 bit mantysy
shl ecx, 28	 ; ecx = xxx0 0000 0000 0000 0000 0000 0000 0000 , ostatnie 3 bity mantysy

mov [edi], esi
mov [edi+4], ecx


pop ebx
pop ebp
ret
_function ENDP
END