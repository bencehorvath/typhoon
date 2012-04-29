/* 	Typhoon kernel
	Copyright (c) 2012, Bence Horvath (twl) horvathb.arch@gmail.com 
	All rights reserved.
*/

void kmain(/*void* mbd,*/ unsigned int magic)
{
	if(magic != 0x2BADB002)
	{
		/* something went wrong. print error.
			do not rely on multiboot! */
	}
	
	/* print a letter, to test */
	unsigned char* videoram = (unsigned char*)0xb8000;
	videoram[0] = 65; /* 'A' character */
	videoram[1] = 0x07; /* light grey (7) on black (0) */
}
