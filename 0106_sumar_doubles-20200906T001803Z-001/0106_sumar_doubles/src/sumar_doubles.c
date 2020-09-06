#include <stdio.h>
extern double sumardoubles(double a, double b);

int main(int argc, char *argv[])
{		
	double rta = sumardoubles(10.2,5.6);
	printf("La respuesta es %f\n", rta);
	return 0;
}

// Modificar sumarenteros para que sume dos numeros de tipo double 
// (ver instrucción ADDPD)