#include <stdio.h>
#include <stdlib.h>

/*
 * 0205
 * Dada una matriz de f x c enteros de 32 bits, encontrar el primer máximo buscando en el orden de la memoria.
 * Devuelve un puntero a este valor y sus coordenadas en f y c.
 * El prototipo de la función es: int* primerMaximo(int (*matriz)[sizeC], int* f, int* c);
 */

extern int* primerMaximo_ASM(int *pMatriz, int *f, int *c);

int* primerMaximo_matriz(int *pMatriz, int *f, int *c)
{
	int filas 		= *f;
	int columnas 	= *c;
	int (*matriz)[columnas] = pMatriz;
	int *pMaximo;

	*f = 0;
	*c = 0;
	pMaximo = &matriz[*f][*c];

	for(int i = 0; i < filas; ++i)
	{
		for(int j = 0; j < columnas; ++j)
		{
			if(matriz[i][j] < *pMaximo)
			{
				return pMaximo;
			}

			if(*pMaximo < matriz[i][j])
			{
				*f = i;
				*c = j;
				pMaximo = &matriz[*f][*c];
			}
		}
	}

	return pMaximo;
}

int* primerMaximo_vector(int *pMatriz, int *f, int *c)
{
	int filas 		= *f;
	int columnas 	= *c;
	int *matriz 	= pMatriz;
	int *pMaximo;

	int iMaximo = 0;
	for(int n = 0; n < (filas * columnas); ++n)
	{
		if(pMatriz[n] < matriz[iMaximo])
		{
			break;
			// resultado_encontrado
		}
		if(pMatriz[iMaximo] < matriz[n])
		{
			// maximo_nuevo_encontrado
			iMaximo = n;
		}
		// resultado_no_encontrado
	}
	// resultado_encontrado
	pMaximo = &matriz[iMaximo];
	*f = iMaximo / columnas;
	*c = iMaximo % columnas;
	return pMaximo;
}

int main(void)
{
	int fila 	= 4;
	int columna = 3;
	int matriz[4][3] =
	{
			{0, 1, 2},
			{3, 5, 7},
			{0, 0, 0},
			{0, 0, 9},
	};

	int f, c;
	int *pMaximo;

	f = fila;
	c = columna;
	pMaximo = primerMaximo_matriz((int*)matriz, &f, &c);
	printf("C_matriz > el máximo: %d, esta en (%d,%d)\r\n", *pMaximo, f, c);

	f = fila;
	c = columna;
	pMaximo = primerMaximo_vector((int*)matriz, &f, &c);
	printf("C_vector > el máximo: %d, esta en (%d,%d)\r\n", *pMaximo, f, c);

	f = fila;
	c = columna;
	pMaximo = primerMaximo_ASM((int*)matriz, &f, &c);
	printf("ASM      > el máximo: %d, esta en (%d,%d)\r\n", *pMaximo, f, c);

	return EXIT_SUCCESS;
}
