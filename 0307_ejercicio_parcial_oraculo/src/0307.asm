extern malloc
extern free

global insertarDespuesDelUltimoTrue
global borrarUltimoFalse

section .text

%define NULL 0
%define FALSE 0
%define SIZE_NODO 24
%define OFFSET_NODO_SIGUIENTE 0
%define OFFSET_NODO_DATO 8
%define OFFSET_NODO_ORACULO 16

; void insertarDespuesDeUltimoTrue
;   rdi <- nodo* l
;	esi <- int nuevoDato
;	rdx <- bool (*oraculo)()
insertarDespuesDelUltimoTrue:
	; armar stackframe
	push rbp
	mov rbp, rsp
	push rbx; rbx <- actual
	mov rbx, rdi
	push r12; r12 <- l
	mov r12, rdi
	push r13; r13d <- nuevoDato
	mov r13d, esi
	push r14; r14 <- oraculo
	mov r14, rdx
	push r15; r15 <- ultimo
	xor r15, r15; r15 = NULL
	sub rsp, 8

	cmp rdi, NULL
	je .fin

	; recorro la lista
	.loop:
		; llamo al oráculo
		call [rbx + OFFSET_NODO_ORACULO]

		; si oráculo es true, marco último
		cmp eax, FALSE
		je .fin_if
		.if_true:
			mov r15, rbx
		.fin_if:

		; avanzo de nodo
		mov rbx, [rbx + OFFSET_NODO_SIGUIENTE]
	cmp rbx, r12
	jne .loop

	; inserto nuevo nodo
	cmp r15, NULL
	je .fin_if2
	.if_true2:
		mov rdi, r15
		mov esi, r13d
		mov rdx, r14
		call insertarDespuesDeNodo
	.fin_if2:

.fin:
	; desarmo stackframe
	add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

; void insertarDespuesDeNodo
; rdi -> nodo* l,
; esi -> int nuevoDato,
; rdx -> bool (*oraculo)()

insertarDespuesDeNodo:
	;stackframe
	push rbp
	mov rbp, rsp
	push r12
	mov r12, rdi; l
	push r13
	mov r13d, esi; nuevoDato
	push r14
	mov r14, rdx; oraculo
	sub rsp, 8

	mov rdi, SIZE_NODO
	call malloc ; rax <- nuevo nodo

	mov [rax + OFFSET_NODO_DATO], r13d
	mov [rax + OFFSET_NODO_ORACULO], r14
	mov rdi, [r12 + OFFSET_NODO_SIGUIENTE]
	mov [rax + OFFSET_NODO_SIGUIENTE], rdi

	mov [r12 + OFFSET_NODO_SIGUIENTE], rax
	
	;fin
	add rsp, 8
	pop r14
	pop r13
	pop r12
	pop rbp
	ret

; void borrarUltimoFalse(nodo** pLista)
borrarUltimoFalse:
	;armo stackframe
	push rbp
	mov rbp, rsp
	push rbx
	mov rbx, rdi ; pLista
	push r12 ; ultimoFalse

	; mov rdi, rdi ; el parámetro ya está en rdi!
	call obtenerPunteroAlPrimero ; (nodo** pLista) -> nodo** primero
	; rax <- nodo** primero

	mov rdi, rax
	call obtenerUltimoFalse ; (nodo** primero) -> nodo** ultimoFalse
	; rax <- nodo** ultimoFalse
	mov r12, rax

	cmp r12, NULL
	je .fin ; si ultimoFalse es NULO, salgo de la función

	mov rdi, rbx
	mov rsi, r12
	call actualizarParametro; (nodo** pLista, nodo** ultimoFalse)

	mov rdi, r12
	call borrarNodo; (nodo** ultimoFalse)

	.fin:
	pop r12
	pop rbx
	pop rbp
	ret

; (nodo** pLista) -> nodo** primero
; rdi -> nodo** pLista
; rax -> nodo** primero
obtenerPunteroAlPrimero:
	push rbp
	mov rbp, rsp
	
	; rsi = actual
	mov rsi, rdi
	
	.loop:
		; avanzo el doble puntero
		mov rsi, [rsi] ; rsi = *actual
		lea rsi, [rsi+OFFSET_NODO_SIGUIENTE] ; rsi = &(rsi->siguiente)

		; evalúo la guarda
		mov rax, [rsi]
		cmp rax, [rdi]
		jne .loop

	mov rax, rsi
	pop rbp
	ret

; (nodo** primero) -> nodo** ultimoFalse
obtenerUltimoFalse:
	push rbp
	mov rbp, rsp
	push rbx
	mov rbx, rdi
	push r12 ; r12 = **actual
	push r13 ; r13 = **ultimoFalse
	xor r13, r13 ; ultimoFalse = NULL
	sub rsp, 8
	
	mov r12, rbx
	
	.loop:
		; consultar oraculo
		mov rax, [r12]
		call [rax + OFFSET_NODO_ORACULO]

		cmp eax, FALSE
		jne .end_if
		.if_true:
			mov r13, r12
		.end_if:

		; avanzo el doble puntero
		mov r12, [r12] ; r12 = *actual
		lea r12, [r12+OFFSET_NODO_SIGUIENTE] ; r12 = &(r12->siguiente)
		
		; evalúo la guarda
		mov rax, [r12]
		cmp rax, [rbx]
	jne .loop

	mov rax, r13
	add rsp, 8
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret

; (nodo** pLista, nodo** ultimoFalse)
; rdi <- **pLista
; rsi <- **ultimoFalse
actualizarParametro:
	push rbp
	mov rbp, rsp

	mov rax, [rsi]
	cmp rax, [rax + OFFSET_NODO_SIGUIENTE]
	jne .if_false
	.if_true:
		mov QWORD [rdi], NULL
		jmp .fin
	.if_false:

	; (*rsi)->siguiente
	mov rax, [rsi]
	mov rax, [rax + OFFSET_NODO_SIGUIENTE]

	mov [rdi], rax

.fin:
	pop rbp
	ret

; (nodo** ultimoFalse)
; rdi <- **ultimoFalse
borrarNodo:
	push rbp
	mov rbp, rsp

	; obtenemos el nodo
	mov rax, [rdi] ; rax = nodo a borrar

	; arreglo la consistencia de la lista
	mov rsi, [rax+OFFSET_NODO_SIGUIENTE]
	mov [rdi], rsi

	; llamamos a free
	mov rdi, rax
	call free

	pop rbp
	ret
