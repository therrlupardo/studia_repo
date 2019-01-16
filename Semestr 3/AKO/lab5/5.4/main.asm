.686
.XMM					; zezwolenie na asemblację rozkazów grupy SSE
.model flat
public _int2float
.code


;void int2float(int* calkowite, float* zmienno_przecinkowe)
_int2float PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov esi, [ebp+8]		; adres tablicy wejściowej
mov ebx, [ebp+12]		; adres tablicy wynikowej

cvtpi2ps xmm5, qword ptr [esi]
movups [ebx], xmm5

pop edi
pop esi
pop ebx
pop ebp
ret
_int2float ENDP

END