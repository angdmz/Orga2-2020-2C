section.text
%define off_lista_prim 0
%define off_nodo_dato 0
%define off_nodo_prox 8
%define NULL 0

global agregarUltimo
extern malloc
extern free

agregarUltimo:
	push rbp
	mov rbp, rsp ;pila alineada
	push rbx
	push r12

	;rdi -> lista_t* list
	;rsi -> int nuevo

	;paso 1: asignar espacio al nuevo nodo con malloc (ojo)
	mov rbx, rdi
	mov r12d, esi
	%define list_ptr rbx
	%define int_nuevo r12
	mov rdi, 16
	call malloc
	%define nodo_ptr rax

	;paso 2: llenar nodo_t* prox con la dirección NULL
	mov qword [nodo_ptr+off_nodo_prox], NULL

	;paso 3: completar el int dato del nodo
	mov [nodo_ptr+off_nodo_dato], int_nuevo

	;paso 4: conectar el nodo con el resto de la lista
	lea rcx, [list_ptr+off_lista_prim]
	
	.recorrer:
	cmp qword [rcx], NULL
	je .agregar
	mov rcx, [rcx]
	lea rcx, [rcx+off_nodo_prox]
	jmp .recorrer

	.agregar:
	mov [rcx], nodo_ptr	

	.fin:
	pop r12
	pop rbx
	pop rbp
	ret