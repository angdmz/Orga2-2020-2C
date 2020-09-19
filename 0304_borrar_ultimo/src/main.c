#include "lista.h"

extern void agregarPrimero(lista_t* unaLista, int unInt);
extern void borrarUltimo(lista_t *unaLista);

int main(int argc, char* argv){
	
	lista_t lista;
	lista.primero = NULL;

	agregarPrimero(&lista, 3);
	agregarPrimero(&lista, 2);
	agregarPrimero(&lista, 1);

	printf("Lista con 3 elementos:\n");
	printList(&lista);
	printf("\n");

	for(int i = 3; i > 0; i--){
		printf("Lista sin el %d:\n", i);
	 	borrarUltimo(&lista);
	 	printList(&lista);
	 	printf("\n");
	}
	
	printf("Lista vacia\n");
	borrarUltimo(&lista);
	printList(&lista);
	printf("\n");

	return 0;

}