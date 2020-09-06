- Todas las funciones de C son extern de manera default, lo importante es que declaremos la aridad de la función porque sino C nos va a tirar un error de declaración implícita (no tiene forma de saber que nuestro símbolo global de ASM es una función con cierta aridad).

- Si tienen dudas sobre el tamaño de algún tipo, pueden utilizar sizeof() en C. Por ejemplo, en el main.c de este ejercicio pueden agregar:
	printf("int: %ld\n", sizeof(int));
	printf("rta: %ld\n", sizeof(rta));
para verificar el tamaño del tipo int o de la variable rta (van a tener el mismo tamaño, ya que rta es un int).

- Incluí un makefile para compilar y correr el código por si lo necesitan. Instrucciones:
	"make" en /src (sin las comillas)
	"./ejec" para correr el código compilado
	"make clean" para borrar los .o y el ejecutable 
