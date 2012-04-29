# Typhoon makefile
# Copyright (c) 2012, Bence Horvath (twl) horvathb.arch@gmail.com 
# All rights reserved.

AS := nasm
ASFLAGS := -f elf
CFLAGS := -m32 -Wall -Wextra -Werror
LDFLAGS := -nostdlib -fno-builtin -nostartfiles -nodefaultlibs
CC := gcc
LD := ld
LINKFLAGS := -melf_i386
CXX := g++
CXXFLAGS :=

SHELL := /bin/bash


all: kernel.img

kernel.img: kernel.bin
	@echo Creating floppy image...
	@echo =========================
	@./create_img.sh kernel.img

kernel.bin: loader.o kernel.o
	$(LD) $(LINKFLAGS) -T linker.ld -o kernel.bin loader.o kernel.o

loader.o:
	$(AS) $(ASFLAGS) -o loader.o loader.asm

kernel.o:
	$(CC) $(CFLAGS) -o kernel.o -c kernel.c
	
clean:
	rm -f *.o
	rm -f *.bin
	rm -f ./dep/pad
