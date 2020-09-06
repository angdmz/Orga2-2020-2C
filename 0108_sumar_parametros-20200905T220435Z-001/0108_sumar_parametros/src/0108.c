#include <stdio.h>
/**
 * Construir una función en ASM que tome 8 parámetros enteros (a0, ..., a7),
 * y retorne el resultado de la operación: a0-a1+a2-a3+a4-a5+a6-a7.
 * La función debe tener la siguiente aridad:
 * int suma_parametros(int a0, int a1, int a2, int a3, 
 *                     int a4, int a5, int a6, int a7);
 */

int suma_parametros(int a0, int a1, int a2, int a3, 
                    int a4, int a5, int a6, int a7);

int main(int argc, char const *argv[])
{
	int res = suma_parametros(1, 2, 3, 4, 5, 6, 7, 8);
	printf("%d", res);
	return 0;
}

/*
PARÁMETROS:

a0 -> EDI
a1 -> ESI
a2 -> EDX
a3 -> ECX
a4 -> R8D
a5 -> R9D
a6 -> Pila
a7 -> Pila

PILA:

-

| rbp | rbp    |
| rip | rbp+8  |
| a6  | rbp+16 |
| a7  | rbp+24 |
| ... |        |
|     |        |

+

*/