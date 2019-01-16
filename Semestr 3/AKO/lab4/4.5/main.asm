public suma_siedmiu_liczb
.code
suma_siedmiu_liczb PROC
	push rbp
	mov rbp, rsp 
	push rbx 
	push rsi 
	push r12 

	mov r10, [rbp+48] 
	mov r11, [rbp+56]
	mov r12, [rbp+64]
	
	mov rax, rcx ;w RAX będzie wynik, ustawia rax=rcx (pierwszy argument funkcji)
	add rax, rdx ;v1+v2
	add rax, r8  ;v1+v2+v3
	add rax, r9	 ;v1+v2+v3+v4
	add rax, r10 ;v1+v2+v3+v4+v5
	add rax, r11 ;v1+v2+v3+v4+v5+v6
	add rax, r12 ;v1+v2+v3+v4+v5+v6+v7
	
; obliczona wartość maksymalna pozostaje w rejestrze RAX i będzie wykorzystana przez kod programu napisany w języku C
	pop r12	
	pop rsi
	pop rbx
	pop rbp
	ret
suma_siedmiu_liczb ENDP
END 
