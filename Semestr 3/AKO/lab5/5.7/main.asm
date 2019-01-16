; Poniższy podprogram jest przystosowany do wywoływania
; z poziomu języka C++ (program arytmc_AVX.cpp) w trybie 64
; bitowym
public FMA
; podprogram oblicza matX=scalarA*matX + matY, tzw. AXPY
; ostatni paramter count informuje o dlugosci wektora
; (float * matX, float * matY, float scalarA, int count);
; rcx rdx xmm2 r9
; matA
; call -> rbp+8
; rbp -> rbp
.code
FMA:
	;prolog i zapamiętanie rejestrów
	push rbp
	mov rbp,rsp
	push rbx
	push rsi
	push rdi
	mov rsi,rcx ; utwórz kopię adresu macierzy A
	mov rdi,rdx ; utwórz kopię adresu macierzy B
	; wyznaczenie liczby powtórzeń ecx<- count/32
	; długość wektora musi być wielokrotnością liczby 32
	mov rdx,0
	mov rbx,32
	mov rax,r9
	div rbx
	xchg rdx,rax
	cmp rax,0
	jne koniec
	mov rcx,rdx ; w rcx ilosc wykonan
	; właściwa pętla obliczeniowa
	again:
		; xmm2 do pamięci (czyli mnożnik scalarA)
		vmovups XMMWORD PTR dana32, xmm2
		; przeniesienie wartosci scalarA do wszystkich 8 części ymm2
		vbroadcastss ymm2,dana32
		; w rejestrze ymm2 jest 8 razy scalarA
		; załadowanie 8 kolejnych elementów macierzy matA do ymm0
		vmovaps ymm0,YMMWORD PTR [rsi]
		; załadowanie 8 kolejnych elementów macierz matB do ymm1
		vmovaps ymm1, YMMWORD PTR [rdi]
		; rozkaz mnożenia typu FMA ymm0 <- ymm0 * ymm2 + ymm1
		VFMADD132PS ymm0,ymm1,ymm2 ; ymmA <- ymmA * ymmC + ymmB
		; czyli wykonano fa[k] = a * fa[k] + fb[k];
		; zapis wyniku do macierzy matA
		vmovaps YMMWORD PTR [rsi],ymm0
		;aktualizacja wskazników
		add rsi,8*4
		add rdi,8*4
		loop again
	koniec:
		pop rdi
		pop rsi
		pop rbx
		pop rbp
		ret
.data
dana32 dd 4 dup (?) ; miejsce na parametr scalarA
END