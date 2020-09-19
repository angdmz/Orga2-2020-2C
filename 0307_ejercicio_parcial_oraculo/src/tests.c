#include <assert.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>

typedef struct nodo_n {
	struct nodo_n *siguiente;
	int dato;
	bool (*oraculo)();
} nodo;

extern void insertarDespuesDelUltimoTrue(nodo *listaCircular, int nuevoDato, bool (*nuevoOraculo)());
extern void borrarUltimoFalse(nodo **listaCircular);

bool TRUE() { return true; }
bool FALSE() { return false; }

nodo *nuevoNodo(int dato, bool valorOraculo) {
	nodo *head = malloc(sizeof(nodo));
	head->siguiente = head;
	head->dato = dato;
	head->oraculo = valorOraculo ? &TRUE:&FALSE;
	
	return head;
}

void free_list(nodo *n) {
	nodo *actual = n;
	do {
		nodo *sig = actual->siguiente;
		free(actual);
		actual = sig;
	} while (actual != n);
}

void insertarDespuesDePos(nodo* lista, int pos, int dato, bool valorOraculo) {
	nodo *n = nuevoNodo(dato, valorOraculo);

	nodo *actual = lista;
	for (int i = 0; i < pos; i++) {
		actual = actual->siguiente;
	}

	n->siguiente = actual->siguiente;
	actual->siguiente = n;
}

void testInsertarVacia() {
	insertarDespuesDelUltimoTrue(NULL, 1, &FALSE);
}

void testInsertarFalse() {
	nodo *head = nuevoNodo(0, false);
	insertarDespuesDelUltimoTrue(head, 1, &TRUE);
	assert(head->dato == 0);
	assert(head->siguiente == head);
	free_list(head);
}

void testInsertarFalseFalse() {
	nodo *head = nuevoNodo(0, false);
	insertarDespuesDePos(head, 0, 1, false);
	insertarDespuesDelUltimoTrue(head, 2, &TRUE);
	assert(head->dato == 0);
	assert(head->siguiente != NULL);
	assert(head->siguiente->dato == 1);
	assert(head->siguiente->siguiente == head);
	free_list(head);
}

void testInsertarFalseTrue() {
	nodo *head = nuevoNodo(0, false);
	insertarDespuesDePos(head, 0, 1, true);
	insertarDespuesDelUltimoTrue(head, 2, &TRUE);
	assert(head->dato == 0);
	assert(head->siguiente != NULL);
	assert(head->siguiente->dato == 1);
	assert(head->siguiente->siguiente != NULL);
	assert(head->siguiente->siguiente->dato == 2);
	assert(head->siguiente->siguiente->siguiente == head);
	free_list(head);
}

void testInsertarTrue() {
	nodo *head = nuevoNodo(0, true);
	insertarDespuesDelUltimoTrue(head, 1, &TRUE);
	assert(head->dato == 0);
	assert(head->siguiente != NULL);
	assert(head->siguiente->dato == 1);
	assert(head->siguiente->siguiente == head);
	free_list(head);
}

void testInsertarTrueTrue() {
	nodo *head = nuevoNodo(0, true);
	insertarDespuesDelUltimoTrue(head, 1, &TRUE);
	insertarDespuesDelUltimoTrue(head, 2, &TRUE);
	assert(head->dato == 0);
	assert(head->siguiente != NULL);
	assert(head->siguiente->dato == 1);
	assert(head->siguiente->siguiente != NULL);
	assert(head->siguiente->siguiente->dato == 2);
	assert(head->siguiente->siguiente->siguiente == head);
	free_list(head);
}

void testInsertarTrueFalse() {
	nodo *head = nuevoNodo(0, true);
	insertarDespuesDelUltimoTrue(head, 1, &FALSE);
	insertarDespuesDelUltimoTrue(head, 2, &TRUE);
	assert(head->dato == 0);
	assert(head->siguiente != NULL);
	assert(head->siguiente->dato == 2);
	assert(head->siguiente->siguiente != NULL);
	assert(head->siguiente->siguiente->dato == 1);
	assert(head->siguiente->siguiente->siguiente == head);
	free_list(head);
}

void testBorrarFalse() {
	nodo *head = nuevoNodo(0, false);
	borrarUltimoFalse(&head);
	assert(head == NULL);
}

void testBorrarFalseFalse() {
	nodo *head = nuevoNodo(0, false);
	insertarDespuesDePos(head, 0, 1, false);
	borrarUltimoFalse(&head);
	assert(head != NULL);
	assert(head->dato == 0);
	assert(head->siguiente == head);
	free_list(head);
}

void testBorrarFalseTrue() {
	nodo *head = nuevoNodo(0, false);
	insertarDespuesDePos(head, 0, 1, true);
	borrarUltimoFalse(&head);
	assert(head != NULL);
	assert(head->dato == 1);
	assert(head->siguiente == head);
	free_list(head);
}

void testBorrarTrue() {
	nodo *head = nuevoNodo(0, true);
	borrarUltimoFalse(&head);
	assert(head != NULL);
	assert(head->dato == 0);
	assert(head->siguiente == head);
	free_list(head);
}

void testBorrarTrueTrue() {
	nodo *head = nuevoNodo(0, true);
	insertarDespuesDelUltimoTrue(head, 1, &TRUE);
	borrarUltimoFalse(&head);
	assert(head != NULL);
	assert(head->dato == 0);
	assert(head->dato == 0);
	assert(head->siguiente != NULL);
	assert(head->siguiente->dato == 1);
	assert(head->siguiente->siguiente != NULL);
	assert(head->siguiente->siguiente == head);
	free_list(head);
}

void testBorrarTrueFalse() {
	nodo *head = nuevoNodo(0, true);
	insertarDespuesDelUltimoTrue(head, 1, &FALSE);
	borrarUltimoFalse(&head);
	assert(head != NULL);
	assert(head->dato == 0);
	assert(head->siguiente == head);
	free_list(head);
}

#define TEST(x) printf("Ejecutando test: %s...",#x); test##x(); printf("...\033[0;32mOK!\033[0m\n\n")

int main(void) {
	setbuf(stdout, NULL);

	printf("---------------------------\n");
	printf("TESTER ORÁCULO, Versión 0.1\n");
	printf("---------------------------\n\n");

	// Insertar: Lista vacía
	TEST(InsertarVacia);

	// Insertar: Listas de 1 nodo
	TEST(InsertarTrue);
	TEST(InsertarFalse);

	// Insertar: Listas de 2 nodos
	TEST(InsertarFalseFalse);
	TEST(InsertarFalseTrue);
	TEST(InsertarTrueTrue);
	TEST(InsertarTrueFalse);

	// Borrar: Listas de 1 nodo
	TEST(BorrarTrue);
	TEST(BorrarFalse);

	// Borrar: Listas de 2 nodos
	TEST(BorrarFalseFalse);
	TEST(BorrarFalseTrue);
	TEST(BorrarTrueTrue);
	TEST(BorrarTrueFalse);

	printf("¡Felicitaciones! ¡Todos los tests pasaron!\n");

	return 0;
}
