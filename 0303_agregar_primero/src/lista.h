#include <stdio.h>
#include <stdlib.h>

typedef struct nodo{
	int dato;              //off 0 (ocupa 4B)
	struct nodo *prox;     //off 8 (ocupa 8B)
}nodo_t;                   //size 16

typedef struct lista{
	nodo_t *primero;  //off 0 (ocupa 8B)
}lista_t;             //size 8



void printList(lista_t* list){
	nodo_t* actual = list->primero;
	printf("Primero: %p\n", actual);
	int i=0;
	while(actual!=NULL){
		printf("(%p) nodo %d: (%d, %p) \n",actual, i, actual->dato, actual->prox);
		actual = actual->prox;
		i++;
	}
}

void vaciarLista(lista_t* list){
	nodo_t* actual = list->primero;
	
	while(actual != NULL){	
		nodo_t* prox = actual-> prox;
		free(actual);
		actual = prox;
	}
}