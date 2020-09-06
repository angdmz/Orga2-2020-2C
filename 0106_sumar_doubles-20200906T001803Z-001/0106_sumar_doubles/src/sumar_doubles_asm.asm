section .text
global sumardoubles

sumardoubles:
	; xmm0: double1
	; xmm1: double2
	push rbp
	mov rbp, rsp

	addpd xmm0, xmm1 ;el resultado queda en xmm0
	;xmm0 que es el registro por donde debo retornar mi resultado,
	;ya que es de punto flotante

	pop rbp ;restauro el rbp de la funcion llamadora
	ret