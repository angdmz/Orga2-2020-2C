- ¡Perdón por el largo del video! Intentamos hacerlo lo más corto posible, pero es un ejercicio de parcial, y hay muchos detalles que nos pareció que eran importantes de explicar a la hora de resolver este tipo de ejercicios. Si ven el video desde la interfaz de de Google Drive, pueden cambiar la velocidad de reproducción (por ejemplo a 1.5x), y bajarla o pausar en los puntos que les resulten importantes. De este modo, el video se entiende *bastante bien*, y su duración se ve considerablemente reducida (la velocidad de reproducción también se puede cambiar si bajan el video y lo ven desde sus computadoras, aunque depende del reproductor con que lo vean).

- Algunos detalles implementativos (ya corregidos en el src):
    + En el segundo video, al obtener el resultado del oráculo, utilizamos `rax` en vez de `eax`. Esto no sería válido ya que el enunciado decía explícitamente que el booleano estaba definido como un valor de 4 bytes. Lo mencionamos en el video, pero por las dudas prestar atención a esta parte.
    + En `insertarDespuesDeNodo` pusimos `push r12, rdi`. ¡Esta instrucción no existe! Lo que quisimos poner fue `push r12` y luego `mov r12, rdi`. Es decir, preservar r12, y luego mover el contenido del registro rdi para que a su vez el mismo se preserve cuando llamemos a otras funciones.
    + En `insertarDespuesDelUltimoTrue`, al desarmar el stackframe quedaron dos `pop rbx` por error.
    + En `actualizarParametro`, entre `cmp rax, [rax + OFFSET_NODO_SIGUIENTE]` y `.if_true:`, tiene que haber un jump condicional! En este caso sería `jne .if_false`.
    + Para que ensamble y linkee adecuadamente, faltaría declarar `extern malloc`, `extern free`, `global insertarDespuesDelUltimoTrue`, `global borrarUltimoFalse`.