section .text
%define off_lista_prim 0
%define off_nodo_dato 0
%define off_nodo_prox 8
%define NULL 0

global borrarPrimero
extern malloc
extern free

borrarPrimero:
	push rbp
	mov rbp, rsp ;pila alineada

	%define list_ptr rdi

	;paso 0: chequear que el nodo exista
	mov r10, [list_ptr+off_lista_prim]
	cmp r10, NULL
	je .fin
	;paso 1: guardarme el puntero al siguiente nodo
	mov rax, [r10+off_nodo_prox]	
	;paso 2: modificar "primero" en la list
	mov [list_ptr+off_lista_prim], rax
	;paso 3: borrar el nodo usando free
	mov rdi, r10
	call free

	.fin:
	pop rbp
	ret