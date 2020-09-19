;------------------------------------------------------------------------------
; Registros a preservar
; Uso RBX [no] - R12 [no] - R13 [no] - R14 [no] - R15 [no]
;
;------------------------------------------------------------------------------
; Stackframe
; Cargo el stackframe
;	push rbp
;	mov rbp, rsp
;	sub rsp, ESPACIO PARA VARIABLES
;	push rbx
;	push r12
;	push r13
;	push r14
;	push r15
;
; Descargo el stackframe
;	pop r15
;	pop r14
;	pop r13
;	pop r12
;	pop rbx
;	add rsp, ESPACIO PARA VARIABLES
;	pop rbp
;
;------------------------------------------------------------------------------
; Lectura de parámetros
; Enteros y Direcciones: 	izq > der	RDI, RSI, RDX, RCX, R8, R9
; Punto flotante: 			izq > der	XMMO a XMM7
; El resto: 				der > izq	en pila
;------------------------------------------------------------------------------

%include "../src/define.asm"

global borrar_nodo_ASM

;----------------------------------------------------------
;
; Firma:
; void borrar_nodo(supernode_t* pNodo)
;
; Retorno:
; 	void						RAX
;
; Argumentos:
;	supernode_t* pNodo			RDI
;
;----------------------------------------------------------
; Identifico los argumentos recibidos
%define _arg_pNodo 		(rdi)

; Variables locales para la operación
%define pNodo 			(r13)
;C	supernode_t *pNodoDer;
;C	supernode_t *pNodoIzq;
%define pNodoDer 		(r14)
%define pNodoIzq 		(r15)

section.text:
borrar_nodo_ASM:
; stackframe init
	push rbp
	mov rbp, rsp
	sub rsp, 8
;	push rbx
;	push r12
	push r13
	push r14
	push r15

; acomodo los argumentos
	mov pNodo, _arg_pNodo

;C	pNodoDer = pNodo->derecha;
	mov rax, [pNodo + supernode_derecha__off]
	mov pNodoDer, rax

;C	pNodoIzq = pNodo->izquierda;
	mov rax, [pNodo + supernode_izquierda__off]
	mov pNodoIzq, rax

;C	pNodoDer->izquierda = pNodoIzq;
	mov rax, pNodoIzq
	mov [pNodoDer + supernode_izquierda__off], rax

;C	pNodoIzq->derecha 	= pNodoDer;
	mov rax, pNodoDer
	mov [pNodoIzq + supernode_derecha__off], rax

;C	free(pNodo);
	mov rdi, pNodo
	call free

; stackframe deinit
	pop r15
	pop r14
	pop r13
;	pop r12
;	pop rbx
	add rsp, 8
	pop rbp
	ret
; \borrar_nodo_ASM2
