#!/bin/bash

var=".as"
var2=".o"

as -32 $1$var -o $1$var2
ld -m elf_i386 $1$var2 -lc -dynamic-linker /lib/ld-linux.so.2 -o $1
./$1