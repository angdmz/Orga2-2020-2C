ASM = $(wildcard *.asm)
ASM_O = $(ASM:.asm=.o)

main: ${ASM} *c
	make ${ASM_O}
	gcc -g -ggdb *.c *.o -o ejec -lm -no-pie

%.o: %.c
	gcc -g -ggdb -lm -no-pie -c -o $@ $<

%.o: %.asm
	nasm -f elf64 -F DWARF $< -g

clean:
	-rm -f *.o ejec