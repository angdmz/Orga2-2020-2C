
#include <stdio.h>
#include <stdlib.h>
#include "define.h"
#include "borrar.h"
#include "agregar.h"

void 			generarListas(int (*setup)[], int nColumnas);
void 			imprimirListas(supernode_t *pNodoEntrada, int nColumnas);
supernode_t* 	obtenerNodo(int fila, int columna);

int setupNodos[3][5] =
{
		{ 1,  2,  3,  4,  5,},
		{ 6,  7,  0,  9,  0,},
		{11,  0,  0, 14,  0,},
};

int main(void)
{
	generarListas(setupNodos, 5);
	supernode_t *pNodoEntrada = obtenerNodo(0, 0);
	supernode_t *pNodoColumna = obtenerNodo(0, 3);
	supernode_t *pNodoArriba = obtenerNodo(0, 4);

	printf("\r\nSetup\r\n\r\n");
	imprimirListas(pNodoEntrada, 5);

	printf("\r\nBorrado\r\n\r\n");
	borrar_columna_C(&pNodoColumna);
	imprimirListas(pNodoEntrada, 5);

	printf("\r\nAgregado\r\n\r\n");
	agregar_abajo_ASM(&pNodoArriba, 16);
	imprimirListas(pNodoEntrada, 5);

	return EXIT_SUCCESS;
}

