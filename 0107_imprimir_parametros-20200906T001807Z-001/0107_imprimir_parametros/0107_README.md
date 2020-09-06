- En la resolución de assembler faltó *CONSIDERAR* el tema de la alineación de la pila a 16 bytes.
    + Esto es *MUY* importante antes de llamar a cualquier función que respete la convención.
    + *SIEMPRE* debe considerarse que la pila esté alineada antes de llamar a una función.
    + A veces no pasa nada, pero en particular para printf no alinear la pila puede llegar a hacer que se rompa todo.
    + En esta resolución no pasó nada porque *armar el stackframe deja la pila alineada*, pero no por ello hay que olvidarse de tener en cuenta la alineación de la pila.

- Durante el video, en 4:55, cuando menciono el float f, en realidad el tipo al que se refiere en la captura como "%f" se corresponde con double (que además es el tipo que pide el ejercicio).