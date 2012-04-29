; Typhoon kernel loader
; Copyright (c) 2012, Bence Horvath (twl) horvathb.arch@gmail.com 
; All rights reserved.

global loader ; make entry point visible to linker

extern kmain ; defined in kernel

; setting up the Multiboot header - see GRUB docs for details
MODULEALIGN equ  1<<0                   ; align loaded modules on page boundaries
MEMINFO     equ  1<<1                   ; provide memory map
FLAGS       equ  MODULEALIGN | MEMINFO  ; this is the Multiboot 'flag' field
MAGIC       equ  0x1BADB002           	; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS)        ; checksum required

section .bss
align 4
stack:
	resb STACKSIZE	; reserve 16k stack on a doubleword

section .text

align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

; reserve initial kernel space
STACKSIZE equ 0x4000	; 16kb

;entry point
loader:
	mov esp, stack + STACKSIZE 	; set up stack
	push eax					; multiboot magic number
	push ebx					; multiboot info structure
	
	call kmain					; call kernel
	
	cli
.hang:
	hlt							; halt computer if kernel returns
	jmp .hang
	

