extern printf
global imprime_parametros

section .data
formato_printf: db 'a: %d, f: %f, s: %s', 10, 0

section .text
; void imprime_parametros(int a, double f, char* s);
; a -> rdi
; f -> xmm0
; s -> rsi
imprime_parametros:
	; Armo stackframe
	push rbp
	mov rbp, rsp

	; printf("a: %d, f: %f, s: %s\n", a, f, s);
	; Cuatro parámetros:
	; - "a: %d, f: %f, s: %s\n" = puntero -> rdi
	; - a = entero -> rsi
	; - f = double -> xmm0
	; - s = puntero -> rdx

	mov rdx, rsi
	mov rsi, rdi
	mov rdi, formato_printf
	; mov xmm0, xmm0
	mov rax, 1
	call printf

	; Fin
	pop rbp
	ret