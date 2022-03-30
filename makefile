$(CC)		= gcc
$(CFAGS)	= -std=gnu99 -ffreestanding -O2 -Wall -Wextra
$(OPATH)	= obj/$1/
$(BPATH)	= bin/$1/

vga_text: vga_text.c
	$(CC) $(CFAGS) -o $(OPATH)$@.o $@.c
