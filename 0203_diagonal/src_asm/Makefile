make:
	nasm -f elf64 -g diagonal.asm -o diagonal.o
	gcc -ggdb -o diagonal diagonal.c diagonal.o

clean:
	rm diagonal diagonal.o
