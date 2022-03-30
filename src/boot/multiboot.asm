/* Declare multiboot header constants */
.set ALIGN,	1<<0			/* align loaded modules on page boundries */
.set MEMINFO,	1<<1			/* provide memory map */
.set FLAGS,	ALIGN | MEMINFO		/* multiboot flag field */
.set MAGIC,	0x1BADB002		/* magic number for finding the boot loader */
.set CHECKSUM,	-(MAGIC + FLAGS)	/* checksum of other header constants to state we are multiboot */

/*
	Declare a multiboot header that marks the program as a kernel. 
	These are msgic numbers documented in the multiboot standard
	The bootloader searches for these in the first 8KiB of the kernel file, 
	aligned at a 32-bit boundry. The signature is in it's own section os 
	the header can be forced to be withing the first 8KiB of the kernel file.
*/

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
stack_bottom:
	.skip 16384 # 16KiB

stack_top:

.section .text
.global _start
.type _start, @function
_start:
	mov $stack_top, %esp
	call kernel_main
	cli
1:	hlt
	jmp 1b

.size _start, . - _start
