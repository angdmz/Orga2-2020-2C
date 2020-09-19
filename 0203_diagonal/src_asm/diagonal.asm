global diagonal

%define SHORT_SIZE 2

section .text

diagonal:

    ; void diagonal(short* matriz, short n, short* vector)
    ; short* matriz -> RDI
    ; short n       -> SI
    ; short* vector -> RDX

    ; Stack Frame (Armado)
    push rbp
    mov rbp, rsp

    ; Preparación
    and rsi, 0xFFFF ; extensión sin signo a 64 bits ('n' no va a ser negativo)

    ; Ciclo
    mov rcx, 0 ; índice de ciclo
    
    .ciclo:
        cmp rcx, rsi
        je .fin_ciclo

        mov r9w, [rdi]
        mov [rdx], r9w

        add rdx, SHORT_SIZE
        lea rdi, [rdi + rsi * SHORT_SIZE + SHORT_SIZE]

        inc rcx
        jmp .ciclo

    .fin_ciclo:

    ; Stack Frame (Limpieza)
    pop rbp

    ret
