#include <stdio.h>
#include <stdlib.h>
#include "define.h"

static struct
{
	int *setup;
	supernode_t *matriz;
	int nColumnas;
	supernode_t *listas[3];
} _self;

supernode_t* obtenerNodo(int fila, int columna)
{
	int (*setup)[_self.nColumnas] = (int(*)[_self.nColumnas])_self.setup;
	supernode_t* (*matriz)[_self.nColumnas] = (supernode_t(*)[_self.nColumnas])_self.matriz;

	return matriz[fila][columna];
}

void _generoListaVertical(void)
{
	supernode_t *pNodoArriba;
	supernode_t *pNodo;

	int (*setup)[_self.nColumnas] = (int(*)[_self.nColumnas])_self.setup;
	supernode_t* (*matriz)[_self.nColumnas] = (supernode_t(*)[_self.nColumnas])_self.matriz;

	for(int j = 0; j < _self.nColumnas; ++j)
	{
		for(int i = 1; i < 3; ++i)
		{
			if(0 != setup[i][j])
			{
				pNodoArriba = matriz[i-1][j];
				pNodo = matriz[i][j];
				pNodoArriba->abajo = pNodo;
			}
		}
	}
}

void _generoListaHorizontal(void)
{
	supernode_t *pPrimerNodo;
	supernode_t *pNodo;
	supernode_t *pNodoDerecho;

	int (*setup)[_self.nColumnas] = (int(*)[_self.nColumnas])_self.setup;
	supernode_t* (*matriz)[_self.nColumnas] = (supernode_t(*)[_self.nColumnas])_self.matriz;

	for(int i = 0; i < 3; ++i)
	{
		pPrimerNodo = NULL;
		for(int j = 0; j < _self.nColumnas; ++j)
		{
			if(0 != setup[i][j])
			{
				if(NULL == pPrimerNodo)
				{
					pPrimerNodo = matriz[i][j];
					pNodo = pPrimerNodo;
				}
				else
				{
					pNodoDerecho = matriz[i][j];
					pNodo->derecha = pNodoDerecho;
					pNodoDerecho->izquierda = pNodo;
					pNodo = pNodoDerecho;
				}
			}
		}
		pNodo->derecha = pPrimerNodo;
		pPrimerNodo->izquierda = pNodo;
	}
}

void _generoLosNodos(void)
{
	supernode_t *pNodo;
	_self.matriz = malloc(sizeof(supernode_t*) * 3 * _self.nColumnas);

	int (*setup)[_self.nColumnas] = (int(*)[_self.nColumnas])_self.setup;
	supernode_t* (*matriz)[_self.nColumnas] = (supernode_t(*)[_self.nColumnas])_self.matriz;

	for(int i = 0; i < 3; ++i)
	{
		for(int j = 0; j < _self.nColumnas; ++j)
		{
			if(0 != setup[i][j])
			{
				pNodo = malloc(sizeof(supernode_t));
				pNodo->abajo = NULL;
				pNodo->derecha = NULL;
				pNodo->izquierda = NULL;
				pNodo->dato = setup[i][j];
				matriz[i][j] = pNodo;
			}
		}
	}
}

void generarListas(int (*setup)[], int nColumnas)
{
	_self.setup = setup;
	_self.nColumnas = nColumnas;

	_generoLosNodos();
	_generoListaHorizontal();
	_generoListaVertical();
}

static void _print_nodo_info(supernode_t *pNodo)
{
	if(NULL == pNodo)
	{
		printf("                  ");
	}
	else
	{
		printf(" [%02d](%02d, %02d, %02d) ",
				pNodo->dato,
				pNodo->izquierda->dato,
				(NULL == pNodo->abajo) ? 0 : pNodo->abajo->dato,
				pNodo->derecha->dato);
	}
}

void imprimirListas(supernode_t *pNodoEntrada, int nColumnas)
{
	supernode_t *pNodo;
	for(int i = 0; i < 3; ++i)
	{
		for(int j = 0; j < nColumnas; ++j)
		{
			pNodo = pNodoEntrada;

			for(int k = 0; k < j; ++k)
			{
				pNodo = pNodo->derecha;
			}

			for(int k = 0; k < i && NULL != pNodo; ++k)
			{
				pNodo = pNodo->abajo;
			}

			_print_nodo_info(pNodo);
		}
		printf("\r\n");
	}
}
