
FE DE ERRATAS
 - No debería haber usado 'rsi' para guardar el 'n', ¡'n' es un short! En realidad tendría que haber usado 'si' (porque nada me garantiza que en los bits más significativos estén limpios).
 - En el video escribí 'section .text:', ¡¡PERO NO VAN LOS DOS PUNTOS AL FINAL!! Hay problemas al debuggear sino. Grabenseló en la memoria porque puede comerles mucho tiempo en el futuro (based on a lot of true stories).
 - Un caso borde que se me escapó es que el código no se comporta bien si la matriz tiene no tiene elementos. Eso habría que, o documentarlo como precondición de la función, o cambiar un poquito el código para que no pase nada si no hay elementos.

INFO EXTRA
 - Quizás lo más interesante que no mencione es que una etiqueta local '.ciclo' bajo 'suma', termina llamandosé 'suma.ciclo'. Se puede hacer un breakpoint usando ese nombre desde GDB y todo.
 - Para más info de etiquetas locales: https://www.nasm.us/doc/nasmdoc3.html#section-3.9
 - Algo que no dije es por qué utilizamos el tipo puntero para 'vector', en vez de utilizar el tipo array. Es un tema del lenguaje basicamente, querramos o no, al pasar un array a una función, se pasa el puntero al primer elemento (se dice que el array 'decae' a un puntero).
    ''When an array name is passed to a function, what is passed is the location of the initial element. Within the called function, this argument is a local variable, and so an array name parameter is a pointer, that is, a variable containing an address.'' ['The C Programming Language' (5.3 Pointers and Arrays)]
