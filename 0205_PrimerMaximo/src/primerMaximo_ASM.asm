;----------------------------------------------------------
;
; Firma:
; int* primerMaximo_vector(int *pMatriz, int *f, int *c)
;
; Retorno:
; 	int*						RAX
;
; Argumentos:
;	int* 		pMatriz			RDI
;	int* 		f				RSI
;	int* 		c				RDX
;
;----------------------------------------------------------

; Identifico los argumentos recibidos
%define argDirMatriz 	(rdi)
%define argDirF 		(rsi)
%define argDirC 		(rdx)

; Variables locales para la operación

; NOMENCLATURA:
; prefijo 	dir		> direccion a memoria
; sufijo 	_b 		> variable de  8bits
; sufijo 	_w 		> variable de 16bits
; sufijo 	_d 		> variable de 32bits
; si no sice nada es variable de 64bits

%define dirMaximo_d 	(r12)
%define dirMatriz_d 	(rsi)
%define nElemento		(rcx)
%define dirF_d 			(r8)
%define dirC_d 			(r9)
%define elementos 		(r10)
%define nMaximo 		(r11)

section.text:
global primerMaximo_ASM

primerMaximo_ASM:
; stackframe init
	push rbp
	mov rbp, rsp
	push rbx
	push r12

; acomodo los argumentos
	mov dirF_d, argDirF
	mov dirC_d, argDirC
	mov dirMatriz_d, argDirMatriz
; calculo la cantidad de elementos
	mov rax, 0
	mov eax, [dirF_d]
	mov ebx, [dirC_d]
	mul ebx
	mov elementos, rax
; cargo el primer maximo
	mov nMaximo, 0
; inicio el ciclo de
	mov nElemento, 0
.loop_maximo:

	mov eax, [dirMatriz_d + nMaximo*4]
	mov ebx, [dirMatriz_d + nElemento*4]

	cmp ebx, eax
	jl .resultado_encontrado

	cmp eax, ebx
	jl .maximo_nuevo_encontrado
	jmp .resultado_no_encontrado

.maximo_nuevo_encontrado:
	mov nMaximo, nElemento

.resultado_no_encontrado:

	inc nElemento
	cmp nElemento, elementos
	jl .loop_maximo
; fin del ciclo

.resultado_encontrado:

	mov rax, nMaximo
	sal rax, 2
	mov dirMaximo_d, dirMatriz_d
	add dirMaximo_d, rax

	mov rdx, 0
	mov rax, nMaximo
	mov ebx, [dirC_d]
	div ebx
	mov [dirF_d], eax
	mov [dirC_d], edx
	mov rax, dirMaximo_d

; stackframe deinit
	pop r12
	pop rbx
	pop rbp
	ret
; \gris_ASM
