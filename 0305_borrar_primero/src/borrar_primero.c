#include <stdio.h>
#include <stdlib.h>
#include "borrar_primero.h"

extern void borrarPrimero(lista_t *unaLista);

int main(int argc, char *argv[])
{		
	lista_t* list = (lista_t*) malloc(8);
	nodo_t* nodo1 = (nodo_t*) malloc(16);
	nodo_t* nodo2 = (nodo_t*) malloc(16);
	nodo_t* nodo3 = (nodo_t*) malloc(16);
	
	//Lleno los nodos con valores y los conecto
	nodo1->dato = 1;
	nodo1->prox = nodo2;
	nodo2->dato = 2;
	nodo2->prox = nodo3;
	nodo3->dato = 3;
	nodo3->prox = NULL;
	//Lleno la estructura list_t
	list->primero = nodo1;

	printf("Lista original:\n");
	printlist(list);

	borrarPrimero(list);

	printf("Lista nueva:\n");
	printlist(list);	
	
	free(nodo3);
	free(nodo2);
	free(list);
	return 0;
}
