typedef struct nodo{
	int dato;              //off 0 (ocupa 4B)
	struct nodo *prox;     //off 8 (ocupa 8B)
}nodo_t;                   //size 16

typedef struct lista{
	nodo_t *primero;  //off 0 (ocupa 8B)
}lista_t;             //size 8



void printlist(lista_t* list){
	nodo_t* actual = list->primero;
	printf("Primero: %p\n", actual);
	int i=0;
	while(actual!=NULL){
		printf("(%p) nodo %d: (%d, %p) \n",actual, i, actual->dato, actual->prox);
		actual = actual->prox;
		i++;
	}
}