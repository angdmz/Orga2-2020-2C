
#include <stdio.h>
#include <stdlib.h>
#include "define.h"
#include "borrar.h"

void borrar_nodo_C(supernode_t* pNodo)
{
	supernode_t *pNodoDer;
	supernode_t *pNodoIzq;

	pNodoDer = pNodo->derecha;
	pNodoIzq = pNodo->izquierda;

	pNodoDer->izquierda = pNodoIzq;
	pNodoIzq->derecha 	= pNodoDer;

	free(pNodo);
}

void borrar_columna_C(supernode_t* *sn)
{
	supernode_t *pNodo;
	supernode_t *pNodoDerecha;
	supernode_t *pSubNodo;

	pNodo = *sn;
	pNodoDerecha = pNodo->derecha;

	while(NULL != pNodo)
	{
		pSubNodo = pNodo->abajo;
		borrar_nodo_ASM(pNodo);
		pNodo = pSubNodo;
	}

	*sn = pNodoDerecha;
}

