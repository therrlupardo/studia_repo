.686
.model flat
public _sortowanie
.data

.code

; unsigned __int64 sortowanie(unsigned __int64*, unsigned int)
_sortowanie PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ecx, [ebp+12]			; liczba elementow
mov ebx, [ebp+8]			; adres tablicy
mov edi, [ebp+8]			; kopia adresu tablicy
add edi, 8					; drugi element tablicy
sub ecx, 2
mov esi, ecx

bubble:
	mov edx, [ebx+4]		; starsza część 1 liczby
	mov eax, [edi+8*esi+4]		; starsza część 2 liczby
	cmp edx, eax
	ja zamien				; jeśli starsza1 > starsza2 zamień je miejscami
	jb dalej				; jeśli starsza1 < starsza2 sortuj dalej
	; w innym wypadku (st1 = st2) sprawdz młodsze części
	mov edx, [ebx]
	mov eax, [edi+8*esi]
	cmp edx, eax			; jeśli mł1 > mł2 zamień miejscami
	ja zamien
	; jeśli nie przejdź do kolejnej liczby
	jmp dalej
zamien:
	mov edx, [ebx+4]
	mov eax, [edi+8*esi+4]
	mov [ebx+4], eax
	mov [edi+8*esi+4], edx
	mov edx, [ebx]
	mov eax, [edi+8*esi]
	mov [ebx], eax
	mov [edi+8*esi], edx
	jmp dalej

dalej:
	; albo przechodzi do kolejnego elementu w edi
	; albo przechodzi do kolejnego w ebx i ustawia edi na kolejny
	cmp esi, 0	; w esi jest jakiśtam iterator, jeśli wynosi on 0, to reset do ecx-1
	je kolejny_ebx
	dec esi
	jmp bubble
kolejny_ebx:
	dec ecx
	mov esi, ecx
	add ebx, 8
	mov edi, ebx
	add edi, 8
	cmp ecx, 0
	jne bubble
koniec:

mov edx, [edi+8*esi+4]
mov eax, [edi+8*esi]

pop esi
pop edi
pop ebx
pop ebp
ret

_sortowanie ENDP

 END