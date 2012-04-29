#!/bin/bash

# Kernel floppy image creator, basic version
# Copyright (c) 2012, Bence Horvath (twl) horvathb.arch@gmail.com 
# All rights reserved.
# Meant to be run by 'make' but can be run manually as well.

if [ -z $1 ]; then
	echo "Usage: $0 <image file name>"
	exit 1
fi

ROOTDIR="."
STAGE1="$ROOTDIR/dep/grub-0.97-i386-pc/boot/grub/stage1"
STAGE2="$ROOTDIR/dep/grub-0.97-i386-pc/boot/grub/stage2"
PADFILE="$ROOTDIR/dep/pad"
KERNEL_FILE="$ROOTDIR/kernel.bin"
FLOPPY_SIZE=1474560

echo
echo "grub stage1 at: $STAGE1"
echo "grub stage2 at: $STAGE2"
echo "creating pad file..."

dd if=/dev/zero of=$PADFILE bs=1 count=750
echo -n "assembling image... "
cat $STAGE1 $STAGE2 $PADFILE $KERNEL_FILE > $1
echo "done!"

# make floppy size
echo "appending to make it floppy-sized"
#CURRENT=`stat -c %s $1`
CURRENT=`du -b $1 | cut -f1`
APPEND=`echo $FLOPPY_SIZE-$CURRENT | bc`
dd if=/dev/zero of=padfloppy.tmp bs=1 count=$APPEND
mv $1 "$1.old"
cat "$1.old" padfloppy.tmp > $1
rm -f "$1.old" padfloppy.tmp $PADFILE

exit 0




