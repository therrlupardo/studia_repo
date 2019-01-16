.686
.model flat
public _roznica

.code
; int roznica(int *, int **)
_roznica PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

; adres adresu zmiennej 2
; adres zmiennej 1
; call
; ebp

mov eax, [ebp+8]	; w eax adres
mov eax, [eax]		; w eax zmienna

mov ebx, [ebp+12]	; w ebx adres adresu
mov ebx, [ebx]		; w ebx adres
mov ebx, [ebx]		; w ebx zmienna

sub eax, ebx ; wykonaj odejmowanie


pop esi
pop edi
pop ebx
pop ebp
ret
_roznica ENDP

END