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

global buscar_nodo_inferior_izquierdo_ASM

;----------------------------------------------------------
;
; Firma:
; supernode_t *buscar_nodo_inferior_izquierdo_C(supernode_t *pNodo)
;
; Retorno:
; 	supernode_t*		RAX
;
; Argumentos:
;	supernode_t *pNodo	RDI
;
;----------------------------------------------------------

; Identifico los argumentos recibidos
%define _arg_pNodo 		(rdi)

; Variables locales para la operación
%define pNodo			(r15)
;C	supernode_t *pNodoIzq;
%define pNodoIzq		(r14)

section.text:
buscar_nodo_inferior_izquierdo_ASM:
; stackframe init
	push rbp
	mov rbp, rsp
;	sub rsp, 0
;	push rbx
;	push r12
;	push r13
	push r14
	push r15

; acomodo los argumentos
	mov pNodo, _arg_pNodo

;C	pNodoIzq = pNodo->izquierda;
	mov rax, [pNodo + supernode_izquierda__off]
	mov pNodoIzq, rax

;C	while(NULL == pNodoIzq->abajo)
;C	{
;C		pNodoIzq = pNodoIzq->izquierda;
;C	}
.while:
	mov rax, [pNodoIzq + supernode_abajo__off]
	cmp rax, NULL
	je .while_when__TRUE
	jmp .while_when__FALSE
.while_when__TRUE:
	mov rax, [pNodoIzq + supernode_izquierda__off]
	mov pNodoIzq, rax
	jmp .while
.while_when__FALSE:

;C	return pNodoIzq->abajo;
	mov rax, [pNodoIzq + supernode_abajo__off]

; stackframe deinit
	pop r15
	pop r14
;	pop r13
;	pop r12
;	pop rbx
;	add rsp, 0
	pop rbp
	ret
; \buscar_nodo_inferior_izquierdo_ASM
