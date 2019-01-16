.686
.XMM					; zezwolenie na asemblację rozkazów grupy SSE
.model flat
public _pm_jeden

.data

jedynki real4 1.0,1.0,1.0,1.0

.code


;void pm_jeden(float* tablica)
_pm_jeden PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov esi, [ebp+8]		; adres tablicy wejściowej
mov edi, offset jedynki

movups xmm5, [edi]

movups xmm6, [esi]

addsubps xmm6, xmm5

movups [esi], xmm6

pop edi
pop esi
pop ebx
pop ebp
ret
_pm_jeden ENDP

END