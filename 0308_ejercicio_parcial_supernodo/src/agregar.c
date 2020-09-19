#include <stdio.h>
#include <stdlib.h>
#include "define.h"
#include "agregar.h"

supernode_t *buscar_nodo_inferior_izquierdo_C(supernode_t *pNodo)
{
	supernode_t *pNodoIzq;
	pNodoIzq = pNodo->izquierda;
	while(NULL == pNodoIzq->abajo)
	{
		pNodoIzq = pNodoIzq->izquierda;
	}
	return pNodoIzq->abajo;
}


void agregar_subnodo_C(supernode_t *pNodo, supernode_t *pSubNodo)
{
	pNodo->abajo = pSubNodo;

	supernode_t *pNodoInfIzq;
	pNodoInfIzq = buscar_nodo_inferior_izquierdo_ASM(pNodo);

	pSubNodo->derecha 		= pNodoInfIzq->derecha;
	pSubNodo->izquierda 	= pNodoInfIzq;

	pNodoInfIzq->derecha->izquierda = pSubNodo;
	pNodoInfIzq->derecha 			= pSubNodo;
}

void agregar_abajo_C(supernode_t **sn, int d)
{
	supernode_t *pNodoNuevo;
	pNodoNuevo = (supernode_t*)malloc(sizeof(supernode_t));
	pNodoNuevo->izquierda 	= NULL;
	pNodoNuevo->derecha 	= NULL;
	pNodoNuevo->abajo 		= NULL;
	pNodoNuevo->dato 		= d;

	supernode_t *pNodo;
	pNodo = *sn;
	agregar_subnodo_ASM(pNodo, pNodoNuevo);
}

