section.text:
	global agregarPrimero
	global borrarUltimo

	extern malloc
	extern free

	agregarPrimero:
		push rbp
		mov rbp, rsp ; pila alineada
		push rbx		 ; pila alineada 8
		push r12		 ; pila alineada 16
		;void agregarPrimero(lista_t* unaLista, int unInt);
		; rdi = *unaLista
		; esi = unInt

		mov rbx, rdi
		mov r12d, esi

		;1. Crear el nodo usando malloc
		mov rdi, 16
		call malloc  ; rax = el puntero a nuevo nodo

		mov [rax], r12d

		;2. Conectar el nuevo nodo a su siguiente en la lista
		mov rdi, [rbx]
		mov [rax + 8], rdi
		
		;3. Conectar el puntero anterior en la lista al nuevo nodo
		mov [rbx], rax

		pop r12
		pop rbx
		pop rbp
		ret


	borrarUltimo:

		push rbp
		mov rbp, rsp ; pila alineada

		; void borrarUltimo(lista_t *unaLista);
		; rdi = *unaLista

		; 1 Encontrar, si existe, el nodo que queremos borrar
		cmp qword [rdi], 0 	;cmp unaLista->primero, 0
		je .fin

		mov rsi, rdi	; rsi = *unaLista
		mov rdi, [rdi]  ; rdi = unaLista->primero
		cmp qword [rdi + 8], 0  ; cmp primero->prox, 0
		je .esElUnico

		.haySiguiente:
			cmp qword [rdi + 8], 0  ; cmp nodoActual->prox, 0
			je .esElUltimo

			mov rsi, rdi		; rsi = nodoAnterior = nodoActual
			mov rdi, [rdi+8]	; nodoActual = nodoActual->prox
			jmp .haySiguiente

		.esElUnico:
			mov qword [rsi], 0  ; unaLista->primero = 0
			call free
			jmp .fin
			
		.esElUltimo:
		; 2	Leer el valor del puntero al siguiente nodo
		; Ya sabemos nodoActual->prox = 0

		; 3 Conectar el nodo anterior al siguiente del nodo a borrar
			mov qword [rsi+8], 0 	; nodoAnterior->prox = 0

		; 4 Borrar el nodo usando free
			call free
		
		.fin:
		pop rbp
		ret