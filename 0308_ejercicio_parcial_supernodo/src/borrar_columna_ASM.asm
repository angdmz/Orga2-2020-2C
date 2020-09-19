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

extern borrar_nodo_ASM
extern borrar_nodo_C

global borrar_columna_ASM

;----------------------------------------------------------
;
; Firma:
; void borrar_columna(supernode_t* *sn)
;
; Retorno:
; 	void				RAX
;
; Argumentos:
;	supernode_t* *		RDI
;
;----------------------------------------------------------

; Identifico los argumentos recibidos
%define _arg_sn 		(rdi)

; Variables locales para la operación
%define sn 				(r12)
;C	supernode_t *pNodo;
;C	supernode_t *pNodoDerecha;
;C	supernode_t *pSubNodo;
%define pNodo 			(r13)
%define pNodoDerecha 	(r14)
%define pSubNodo 		(r15)

section.text:
borrar_columna_ASM:
; stackframe init
	push rbp
	mov rbp, rsp
	sub rsp, 0
;	push rbx
	push r12
	push r13
	push r14
	push r15

; acomodo los argumentos
	mov sn, _arg_sn

;C	pNodo = *sn;
	mov pNodo, [sn]
;C	pNodoDerecha = pNodo->derecha;
	mov rax, [pNodo + supernode_derecha__off]
	mov pNodoDerecha, rax

;C	while(NULL != pNodo)
;C	{
;C		pSubNodo = pNodo->abajo;
;C		borrar_nodo_C2(pNodo);
;C		pNodo = pSubNodo;
;C	}
.while:
	mov rax, pNodo
	cmp rax, NULL
	je .while_when__FALSE
	jmp .while_when__TRUE

.while_when__TRUE:

	mov rax, [pNodo + supernode_abajo__off]
	mov pSubNodo, rax

	mov rdi, pNodo
	call borrar_nodo_ASM
	mov rax, pSubNodo

	mov pNodo, rax

	jmp .while
.while_when__FALSE:

;C	*sn = pNodoDerecha;
	mov [sn], pNodoDerecha

; stackframe deinit
	pop r15
	pop r14
	pop r13
	pop r12
;	pop rbx
	add rsp, 0
	pop rbp
	ret
; \borrar_columna_ASM
