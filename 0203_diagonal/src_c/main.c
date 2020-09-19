
#include <stdio.h>

// Dada una matriz de n*n enteros de 16 bits, devolver los
// elementos de la diagonal en el vector pasado por
// parametro.

void diagonal(short* matriz, short n, short* vector);

int main(int argc, char* argv[]) {
	// Inicialización
	short matriz[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
	short res[3];

	// Llamado a función
	diagonal((short*) matriz, 3, res);

	// Muestra en pantalla
	printf("Diagonal = ");
	for (int i = 0; i < 3; i++) printf("%hd ", res[i]);
	printf("\n");

	// Finalización
	return 0;
}

void diagonal(short* matriz, short n, short* vector) {
	for (int i = 0; i < n; i++) {
		vector[i] = matriz[i * n + i];
	}

}
