#include <stdio.h>
/**
 * Construir una función en ASM que imprima correctamente por pantalla 
 * sus parámetros en orden, llamando sólo una vez a printf. 
 * La función debe tener la siguiente aridad: 
 * void imprime_parametros( int a, double f, char* s );
 */

// Declaración
void imprime_parametros(int a, double f, char* s);

int main(int argc, char const *argv[])
{
	imprime_parametros(10, 2.5, "hola!");
	return 0;
}

/*
// Definición
void imprime_parametros( int a, double f, char* s ) {
	printf("a: %d, f: %f, s: %s\n", a, f, s);
}
*/
