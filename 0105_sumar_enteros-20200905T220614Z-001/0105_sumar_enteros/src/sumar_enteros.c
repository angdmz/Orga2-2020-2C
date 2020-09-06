#include <stdio.h>
extern int sumarenteros(int entero_1, int entero_2);

int main(int argc, char *argv[])
{		
	int rta = sumarenteros(10,5);
	printf("La respuesta es %d \n", rta);
	return 0;
}