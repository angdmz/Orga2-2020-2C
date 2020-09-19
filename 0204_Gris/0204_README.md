nasm -f elf64 gris_ASM.asm -o gris_ASM.o
gcc -no-pie -c -m64 main.c -o main.o
gcc -no-pie -o ej0204 -m64 main.o gris_ASM.o

En el PDF hay una explicación más extensa del problema, por si quedaban dudas.