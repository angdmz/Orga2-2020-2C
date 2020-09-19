CFLAGS=-Wall -Wextra -pedantic -ggdb -O0 -no-pie
ASMFLAGS=-f elf64 -g -F dwarf

.PHONY: all clean

all: tests

clean:
	rm -f *.o
	rm tests

0307.o: 0307.asm
	nasm $(ASMFLAGS) $< -o $@

tests.o: tests.c
	$(CC) $(CFLAGS) -c $< -o $@

tests: tests.o 0307.o
	$(CC) $(CFLAGS) $^ -o $@
