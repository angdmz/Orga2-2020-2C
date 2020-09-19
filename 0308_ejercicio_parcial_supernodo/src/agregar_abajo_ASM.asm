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

extern agregar_subnodo_C
extern agregar_subnodo_ASM

global agregar_abajo_ASM

;----------------------------------------------------------
;
; Firma:
; void agregar_abajo(supernode_t **sn, int d)
;
; Retorno:
; 	void
;
; Argumentos:
;	supernode_t **sn		RDI
;	int d					RSI
;
;----------------------------------------------------------

; Identifico los argumentos recibidos
%define _arg_sn_pp 		(rdi)
%define _arg_d_d 		(esi)

; Variables locales para la operación
%define ppNodo 			(r15)
%define dato_d 			(r14d)

;C	supernode_t *pNodoNuevo;
%define pNodoNuevo 		(r13)
;C	supernode_t *pNodo;
%define pNodo 			(r12)

section.text:
agregar_abajo_ASM:
; stackframe init
	push rbp
	mov rbp, rsp
;	sub rsp, 0
;	push rbx
	push r12
	push r13
	push r14
	push r15

; acomodo los argumentos
	mov ppNodo, _arg_sn_pp
	mov dato_d, _arg_d_d

;C	pNodoNuevo = (supernode_t*)malloc(sizeof(supernode_t));
;C	pNodoNuevo->izquierda 	= NULL;
;C	pNodoNuevo->derecha 	= NULL;
;C	pNodoNuevo->abajo 		= NULL;
;C	pNodoNuevo->dato 		= d;
	mov rdi, supernode__size
	call malloc
	mov pNodoNuevo, rax
	mov rax, NULL
	mov [pNodoNuevo + supernode_izquierda__off], rax
	mov [pNodoNuevo + supernode_derecha__off], rax
	mov [pNodoNuevo + supernode_abajo__off], rax
	mov [pNodoNuevo + supernode_dato__off], dato_d

;C	supernode_t *pNodo;
;C	pNodo = *sn;
;C	agregar_subnodo_c(pNodo, pNodoNuevo);
	mov pNodo, [ppNodo]
	mov rdi, pNodo
	mov rsi, pNodoNuevo
	call agregar_subnodo_ASM

; stackframe deinit
	pop r15
	pop r14
	pop r13
	pop r12
;	pop rbx
;	add rsp, 0
	pop rbp
	ret
; \borrar_columna_ASM
