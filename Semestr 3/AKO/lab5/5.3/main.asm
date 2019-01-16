.686
.XMM					; zezwolenie na asemblację rozkazów grupy SSE
.model flat
public _sumuj_SSE
.code

_sumuj_SSE PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov esi, [ebp+8]		; adres liczby_A[]
mov edi, [ebp+12]		; adres liczby_B[]
mov ebx, [ebp+16]		; adres wyniki[]

movups xmm5, [esi]		; wrzucamy liczby_A jako wektor 16 liczb 8-bitowych
movups xmm6, [edi]		; wrzucamy liczby_B jako wektor 16 liczb 8-bitowych
paddsb xmm5, xmm6
movups [ebx], xmm5

pop edi
pop esi
pop ebx
pop ebp
ret
_sumuj_SSE ENDP

END