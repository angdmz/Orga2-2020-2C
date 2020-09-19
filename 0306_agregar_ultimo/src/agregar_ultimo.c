#include <stdio.h>
#include <stdlib.h>
#include "agregar_ultimo.h"

extern void agregarUltimo(lista_t* unaLista, int unInt);

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

	int nuevo = 4;
	agregarUltimo(list, nuevo);

	printf("Lista nueva:\n");
	printlist(list);	
	
	nodo_t* nodo4 = nodo3->prox;

	free(nodo4);
	free(nodo3);
	free(nodo2);
	free(nodo1);
	free(list);
	return 0;
}
