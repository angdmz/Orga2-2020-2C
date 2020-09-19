nasm -f elf64 primerMaximo_ASM.asm -o primerMaximo_ASM.o
gcc -no-pie -c -m64 main.c -o main.o
gcc -no-pie -o ej0205 -m64 main.o primerMaximo_ASM.o