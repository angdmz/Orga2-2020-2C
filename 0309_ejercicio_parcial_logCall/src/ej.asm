; == LogCall ==
;
; Un obstinado desarollador de software está utilizando una compleja biblioteca de funciones desarrollada en
; un extraño y desconocido lenguaje de programación. Esta biblioteca tiene errores, por lo que el astuto
; desarrollador planteó un experimento para analizar todo el árbol de llamadas a funciones.
; El experimento consta de reemplazar en el código compilado todas las instrucciones call x, por la
; instrucción call log_call. La función log_call tiene como objetivo loggear datos del llamado antes de
; hacerlo propiamente.
;
; Para ello se encargará de realizar los tres pasos siguientes:
;   1. Obtener la dirección de la función original (es decir la dirección de x )
;   2. Almacenar en el log de llamadas datos para el seguimiento
;   3. Llamar a la función x, como si nunca se hubiera llamado a log_call
;
; Para los pasos 1 y 2 se proveen las siguiente funciones que deberán utilizar:
;   1. void* get_func(void* addr_call)
;      Retorna el puntero a la función original dada la posición de memoria de la instrucción call.
;   2. void store_data(void* rsp, void* rbp, void* func)
;      Almacena en el log de llamadas los valores que tenı́an rsp y rbp justo antes de la llamada a la función x,
;      y el puntero func obtenido mediante la función anterior.
;
; A. Programar en ASM la función log_call. Recordar que se debe respetar el estado del programa original
; en todo momento.
;
; Nota: Considerar que la instrucción call ocupa exactamente 5 bytes. Además las funciónes dadas respetan
;       convención C, con la salvedad que no afectan los registos xmm1 a xmm15.

; Ejemplo
; La funcion "f" es un ejemplo de una función implementada con la convención logCall.

global f
extern printf

section .rodata
format: db "- %i -",10,0

section .text

; --- Funciones Auxiliares de logCall ---

get_func:
  ; define una tabla de direcciones de memoria a punteros a funciones
  cmp rdi, f.addrSuma1
  jz .fun_suma
  cmp rdi, f.addrSuma2
  jz .fun_suma
  cmp rdi, f.addrPrintf1
  jz .fun_printf
  cmp rdi, f.addrPrintf2
  jz .fun_printf
  mov rax, 0
  ret
  .fun_printf:
  mov rax, _printf
  ret
  .fun_suma:
  mov rax, _suma
  ret

_suma:
  mov rax, rdi
  add rax, rsi
  ret

_printf:
  jmp printf

; la funcion store_data esta implementada en C.
extern store_data

; --- Funcion principal ---

f:
  push rbp
  mov rbp, rsp
  mov rdi, 12
  mov rsi, 13
  .addrSuma1:
  call log_call
  mov rdi, format
  mov rsi, rax
  .addrPrintf1:
  call log_call
  mov rdi, 28
  mov rsi, 22
  .addrSuma2:
  call log_call
  mov rdi, format
  mov rsi, rax
  .addrPrintf2:
  call log_call
  pop rbp
  ret

; --- Funcion logCall ---

; Pila antes de llamar a get_func

; |         |
; | xmm0low | <- rsp+0*8
; | xmm0hi  | <- rsp+1*8
; |   r11   | <- rsp+2*8
; |   r10   | <- rsp+3*8
; |   r9    | <- rsp+4*8
; |   r8    | <- rsp+5*8
; |   rcx   | <- rsp+6*8
; |   rdx   | <- rsp+7*8
; |   rsi   | <- rsp+8*8
; |   rdi   | <- rsp+9*8
; |   rax   | <- rsp+10*8
; | ------- | <- rsp+11*8
; | ------- | <- rsp+12*8
; | retorno | <- rsp+13*8
; |xxxxxxxxx| <- rsp+14*8
; |xxxxxxxxx| <- rsp+15*8

log_call:
    sub rsp, 16
    push rax
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    sub rsp, 16
    movdqu [rsp], xmm0
    ;   1. Obtener la dirección de la función original (es decir la dirección de x )
    mov rdi, [rsp + 13*8]
    sub rdi, 5
    call get_func
    ;   2. Almacenar en el log de llamadas datos para el seguimiento
    mov [rsp + 12*8], rax
    mov rdx, rax
    mov rsi, rbp
    lea rdi, [rsp + 14*8]
    call store_data
    movdqu xmm0, [rsp]
    add rsp, 16
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rax
    add rsp, 8
    ;   3. Llamar a la función x, como si nunca se hubiera llamado a log_call
    ret
