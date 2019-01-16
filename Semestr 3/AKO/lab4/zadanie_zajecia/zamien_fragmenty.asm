public zamien
extern malloc : PROC
.code

;int zamien(char*, char*, char*);
zamien PROC
push rbp
mov rbp, rsp
push rbx
push rsi
push rdi
push r12
push r13
push r14
push r15

; 64bit assembly -> parametry w RCX, RDX, R8
; RCX -> adres tablicy tekst
; RDX -> adres tekstu do zamiany
; R8  -> adres tekstu do wpisania 

mov rsi, rcx			; w rsi tekst

; policz znaki tekstu
push rsi
push rdx
mov rdx, 0			; licznik znaków
licz_znaki:
	mov al, byte ptr [rsi]
	cmp al, 0
	je policzone
	inc rdx
	inc rsi
	jmp licz_znaki
policzone:
mov rcx, rdx
inc rcx ; żeby ostatni element też był 0

; alokacaja pamięci do przepisywania tablicy
push r8
push rcx
call malloc
pop rcx
pop r8
pop rdx
pop rsi

; uzupełnianie zalokowanej pamięci zerami
push rax
push rcx
zeruj:
	mov [rax], byte ptr 0
	inc rax
	loop zeruj
pop rcx
pop rax


; szukanie podciągów w tekście i zamiana na inne ciągi znaków
; rax - pamięć do wpisywania
; rsi - pamięć do przeszukania
; rcx - długość tekstu do przeszukania
; rdx - tekst szukany
; r8  - tekst do wpisania
mov r15, 0				; licznik wystąpień szukanego tekstu
push rax
push rsi
; zerowanie rejestrów dla łatwiejszego przeglądania rejestrów w debuggerze 
mov r10, 0
mov r11, 0
szukaj:
	mov r10b, [rsi]		; aktualna litera tekstu przeszukiwanego
	mov r11b, [rdx]		; pierwsza litera tekstu szukanego
	cmp r10b, r11b		; porównanie znaków tekstu sprawdzanego i szukanego
	jne szukaj_dalej	; jeśli różne przejdź do kolejnego znaku
	; zapamiętaj gdzie byliśmy przed sprawdzeniem
	mov r12, rdx		
	mov r13, rsi		
	szukaj_podciagu:
		; przejdź do kolejnego znaku tekstu szukanego i sprawdzanego
		inc rdx
		inc rsi	
		; przepisz sprawdzane znaki do rejestrów
		mov r10b, [rsi]
		mov r11b, [rdx]
		cmp r11b, 0		; czy skończył się już tekst sprawdzany?
		je znaleziono_podciag   ; jeśli tak skocz do wpisywania 
		cmp r10b, r11b		; czy znaki dalej pasują do podciągu?
		jne nie_znaleziono_podciagu	; jeśli nie zakończ szukanie	
		jmp szukaj_podciagu		; sprawdź kolejne znaki w poszukiwaniu podciągu
		
znaleziono_podciag:
	inc r15			; zwiększ licznik znalezień
	mov rdx, r12		; rdx - tekst szukany

	; wpisz tekst na miejsce znalezionego
	mov r12, r8		; zapis powrotu dla tekstu wpisywanego
	wpisz:
		mov r11b, [r8]	; wpisz do rejestru wpisywany znak
		cmp r11b, 0	; czy koniec tekstu wpisywanego?
		je zakoncz_wpisywanie
		mov [rax], r11b ; wpisz znak to tablicy wynikowej
		inc rax		; przesuń iterator tablicy wynikowej
		inc r8		; przesuń iterator tekstu wpisywanego
		jmp wpisz	; kontynuuj wpisywanie
	zakoncz_wpisywanie:
		mov r8,r12	; przywróć tekst wpisywany do pierwotnego stanu
		jmp szukaj_dalej ; szukaj innych podciągów

nie_znaleziono_podciagu:
	; przywróć teksty szukany i przeszukiwany do pierwotnego stanu
	mov rdx, r12
	mov rsi, r13


szukaj_dalej:
	inc rsi			; kolejny znak tekstu przeszukiwanego
	cmp r10b, 0		; czy to był ostatni znak w tekście?
	je koniec_szukania	; jeśli tak zakończ 
	mov [rax], r10b		; jeśli nie wpisz do tablicy wynikowej
	inc rax			; przejdź do kolejnego znaku w tablicy wynikowej
	jmp szukaj		; szukaj dalej

koniec_szukania:
pop rsi
pop rax
mov rcx, rsi

; przepisz rax do rcx
; pozostałe rejestry (za wyjątkiem r15) nie mają znaczenia 
; w rsi adres początkowy rcx -> możemy wpisywać do rsi

przepisz:
	mov r10b, [rax]		; przepisz znak z tablicy wynikowej do rejestru
	mov [rsi], r10b		; przepisz znak z rejestru do tablicy początkowej
	cmp r10b, 0		; jeśli było to 0 (zakończenie tekstu) to uzupełnij pozostałe miejsca zerami
	je uzupelnij_zerami	
	; przejdź do kolejnych znaków
	inc rsi			
	inc rax
	jmp przepisz

uzupelnij_zerami:
	mov r10b, [rsi]		; pobierz znak z tablicy początkowej
	cmp r10b, 0		; jeśli było to 0 (zakończenie tekstu) to zakończ
	je zakoncz
	mov [rsi], byte ptr 0	; jeśli nie wpisz na jego miejsce 0
	inc rsi			; przejdź do kolejnego znaku
	jmp uzupelnij_zerami

zakoncz:
mov rax, r15			; w rax musi być zwracana wartość -> liczona w r15 liczba powtórzeń szukanego tekstu

pop r15
pop r14
pop r13
pop r12
pop rdi
pop rsi
pop rbx
pop rbp
ret
zamien ENDP
END
