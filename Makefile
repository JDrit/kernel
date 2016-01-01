CC = i686-elf-gcc
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
OUTPUT = myos.bin

AA = i686-elf-as

kernel.bin : kernel.o boot.o
	$(CC) -T linker.ld -o $(OUTPUT) -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

kernel.o : kernel.c
	$(CC) -c kernel.c -o kernel.o $(CFLAGS)

boot.o : boot.s
	$(AA) boot.s -o boot.o

iso: kernel.bin
	mkdir -p isodir/boot/grub
	cp $(OUTPUT) isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub2-mkrescue -o myos.iso isodir

.PHONY: clean
clean:
	rm -rf $(OUTPUT) kernel.o boot.o isodir
