#!/bin/bash
rm ./lib_st.a
rm ./main_a.o
rm ./main_so.o
rm ./test_dyn.o
rm ./lib_dyn.so
rm ./test_dyn.out
gcc -c main_a.c -o main_a.o
ar r lib_st.a main_a.o
gcc -c -Wall -fPIC -D_GNU_SOURCE main_so.c
gcc main_so.o -shared -o lib_dyn.so
gcc -c main.c -o test_dyn.o
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:."
gcc test_dyn.o lib_st.a -L. -l_dyn -o test_dyn.out
clear
