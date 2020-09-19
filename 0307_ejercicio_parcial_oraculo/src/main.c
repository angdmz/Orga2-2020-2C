typedef struct nodo_n {
	struct nodo* siguiente; // 8 bytes -> 0-8
	int dato; // 4 bytes -> 8-12
	bool (*oraculo)(); // 8 bytes -> 16-24
} nodo; // 24 bytes

void insertarDespuesDeUltimoTrue(nodo* l, int nuevoDato, bool (*oraculo)());

void borrarUltimoFalse(nodo* l);

void insertarDespuesDeNodo(nodo* l, int nuevoDato, bool (*oraculo)());

void insertarDespuesDeUltimoTrue(nodo* l, int nuevoDato, bool (*oraculo)()) {
	nodo* actual = l;
	nodo* ultimo = NULL;

	// Recorro la lista
	do {
		// consultar oráculo
		bool respuesta = actual->oraculo();
		if(respuesta){
			ultimo = actual;
		}

		// avanzar de nodo
		actual = actual->siguiente;
	} while(actual != l);

	if(ultimo!=NULL){
		insertarDespuesDeNodo(ultimo, nuevoDato, oraculo);		
	}
}

void insertarDespuesDeNodo(nodo* l, int nuevoDato, bool (*oraculo)()){
	
	nodo* nuevoNodo = malloc(sizeof(nodo));
	nuevoNodo->dato = nuevoDato;
	nuevoNodo->oraculo = oraculo;
	nuevoNodo->siguiente = l->siguiente;

	l->siguiente = nuevoNodo;
}