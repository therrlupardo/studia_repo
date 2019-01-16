.686
.model flat
public _plus_jeden

.data
; BŁĄD 1 - zbędna linia
; mantysa	dd 0
wykladnik	dd 0

.code
; float dodaj_jeden (float)
_plus_jeden PROC	
; BŁĄD 2 - błędny prolog, jak najpierw będzie push ebx to ebp będzie wskazywać na ebx nie na swój adres
; push ebp
; push ebx
; mov ebp, esp			
push ebp
mov ebp, esp
push ebx

finit
mov eax, [ebp+8]		; w eax argument float
shr eax, 23				; w eax wykładnik
mov wykladnik, eax
cmp eax, 127
jae wieksza_od_1
; ropzpatrujemy liczbę < 1
mov eax, [ebp+8]
shl eax, 9
shr eax, 9
bts eax, 23				; ustawiamy jawną 1
mov ecx, 127
sub ecx, wykladnik		; wykladnik < 127, więc ecx > 0

shr eax, cl				; nie stracimy dokładności przypadkiem?

mov ecx, 127
shl ecx, 23
or eax, ecx
jmp koniec

wieksza_od_1:
mov eax, 0
bts eax, 23				; jedynka do dodania
mov ecx, wykladnik		; niespolaryzowany wykładnik
sub ecx, 127
shr eax, cl
mov ebx, [ebp+8]
shl ebx, 9				;  pozbywamy się wykładnika
shr ebx, 9
bts ebx, 23				; jawna 1
add eax, ebx
; BŁĄD 3 - powinniśmy sprawdzać w eax, nie w ebx
; BŁĄD 4 - powinniśmy sprawdzać na 24 bicie, nie 23, ponieważ na 23 mamy 1 z ebx zawsze, jeśli pojawi się nowa 1 to będzie na 24
; bt ebx, 23
bt eax, 24				; eax?
jnc bez_korekcji
shr eax, 1
add wykladnik, 1

bez_korekcji:		
; BŁĄD 5 - jedynka nie jest zerowana
btr eax, 23
	; mamy manysę
	mov ebx, wykladnik
	shl ebx, 23
	or eax, ebx

koniec:

push eax
; BŁĄD 6 - wrzucamy liczbę 32 bitową (dword), nie 64 (qword)
; BŁĄD 7 - bierzemy wartość ze stosu (esp), nie z eax
; fld qword ptr [eax]
fld dword ptr [esp]
add esp, 4

pop ebx
pop ebp
ret
_plus_jeden ENDP

 END