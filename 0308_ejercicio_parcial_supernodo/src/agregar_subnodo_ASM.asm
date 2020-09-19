;------------------------------------------------------------------------------
;
; Reg |  A  |  B  |  C  |  D  |  DI  |  SI  |  BP	 |  SP  | R8  ... R15
; -----------------------------------------------------------------------
;   8 |  AL |  BL |  CL |  DL |  DIL |  SIL |  BPL   |  SPL | R8B ... R15B
;  16 |  AX |  BX |  CX |  DX |  DI  |  SI  |  BP    |  SP  | R8W ... R15W
;  32 | EAX | EBX | ECX | EDX | EDI  | ESI  | EBP    | ESP  | R8D ... R15D
;  64 | RAX | RBX | RCX | RDX | RDI  | RSI  | RBP    | RSP  | R8  ... R15
;
; 128 | XMM0 ... XMM15
;
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

extern buscar_nodo_inferior_izquierdo_C
extern buscar_nodo_inferior_izquierdo_ASM

global agregar_subnodo_ASM

;----------------------------------------------------------
;
; Firma:
; void agregar_subnodo_C(supernode_t *pNodo, supernode_t *pSubNodo)
;


; Retorno:
;	void
;
; Argumentos:
;	supernode_t *pNodo		RDI
;	supernode_t *pSubNodo	RSI
;
;----------------------------------------------------------

; Identifico los argumentos recibidos
%define _arg_pNodo 		(rdi)
%define _arg_pSubNodo 	(rsi)

; Variables locales para la operación
%define pNodo			(r15)
%define pSubNodo		(r14)
;	supernode_t *pNodoInfIzq;
%define pNodoInfIzq		(r13)

section.text:
agregar_subnodo_ASM:
; stackframe init
	push rbp
	mov rbp, rsp
;	sub rsp, 0
	push rbx
;	push r12
	push r13
	push r14
	push r15

; acomodo los argumentos
	mov pNodo, _arg_pNodo
	mov pSubNodo, _arg_pSubNodo

;C	pNodo->abajo = pSubNodo;
	mov rax, pSubNodo
	mov [pNodo + supernode_abajo__off], rax

;C	pNodoInfIzq = buscar_nodo_inferior_izquierdo_C(pNodo);
	mov rdi, pNodo
	call buscar_nodo_inferior_izquierdo_ASM
	mov pNodoInfIzq, rax

;C	pSubNodo->derecha = pNodoInfIzq->derecha;
	mov rax, [pNodoInfIzq + supernode_derecha__off]
	mov [pSubNodo + supernode_derecha__off], rax

;C	pSubNodo->izquierda = pNodoInfIzq;
	mov rax, pNodoInfIzq
	mov [pSubNodo + supernode_izquierda__off], rax

;C	pNodoInfIzq->derecha->izquierda = pSubNodo;
	mov rax, pSubNodo
	mov rbx, [pNodoInfIzq + supernode_derecha__off]
	mov [rbx + supernode_izquierda__off], rax

;C	pNodoInfIzq->derecha = pSubNodo;
	mov rax, pSubNodo
	mov [pNodoInfIzq + supernode_derecha__off], rax

; stackframe deinit
	pop r15
	pop r14
	pop r13
;	pop r12
	pop rbx
;	add rsp, 0
	pop rbp
	ret
; \agregar_subnodo_ASM
