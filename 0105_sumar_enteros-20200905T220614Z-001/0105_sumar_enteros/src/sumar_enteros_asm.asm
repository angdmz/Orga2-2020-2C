section .text
global sumarenteros
sumarenteros:
	push rbp
	mov rbp, rsp
	; edi: entero1
	; esi: entero2
	add edi, esi ; el resultado queda en edi
	; se devuelven resultados por eax
	mov eax, edi 
	pop rbp
	ret
