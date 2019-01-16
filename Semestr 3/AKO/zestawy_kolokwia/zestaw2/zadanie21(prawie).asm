.686
.model flat
public _float_razy_float
.code
; float float_razy_float(float a, float b);
_float_razy_float PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov eax, [ebp+8]		; eax = a
mov ebx, [ebp+12]		; ebx = b

; obliczany bit znaku liczby, jeśli będzie + = 0, - = 1; xor(+,-) = -, xor(+,+) = xor(-,-) = +
; najpierw zerowanie pozostałych bitów, nie są potrzebne na razie
mov ecx, eax
shr ecx, 31
shl ecx, 31
mov edx, ebx
shr edx, 31
shl edx, 31
xor ecx, edx
; w ecx mamy na razie tylko bit znaku 

; wykładniki do esi, edi
mov esi, eax
shl esi, 1
shr esi, 24
sub esi, 127
mov edi, ebx
shl edi, 1
shr edi, 24
sub edi, 127
add esi, edi			; esi = suma wykładników (bo 2^n * 2^m = 2^(n+m)
add esi, 127			; nie wiem czemu 126 zamiast 127, ale wyniki są bardziej prawdziwe

; mantysy zostają w eax, ebx
and eax, 007fffffh
and ebx, 007fffffh

; w edi będzie iloczyn mantys (1.x * 1.y) = (1+0.x)*(1+0.y) = 1 + 0.x + 0.y + 0.x*0.y
mov edi, 0
bts edi, 23
add edi, eax
add edi, ebx
mov edx, 0
mul ebx				; edx:eax = eax * ebx


push ecx
mov ecx, 23
przesun:
	shr edx, 1
	rcr eax, 1
	loop przesun
pop ecx

xor eax, edi
and eax, 00000000011111111111111111111111b

shl esi, 23
add eax, esi
xor eax, ecx



koniec:
finit
push eax
fld dword ptr [esp]
add esp, 4

pop esi
pop edi
pop ebx
pop ebp
ret
_float_razy_float ENDP
END