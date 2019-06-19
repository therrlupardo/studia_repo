clc
clear all
close all

warning('off','all')

load trajektoria1

N = 90;
[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  % aproksymacja wsp. 'x'.


