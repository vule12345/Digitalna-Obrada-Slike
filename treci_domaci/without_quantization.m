clear
clc
close all

lena = imread('lena.tif');

im2dos_quan(lena, 64, 'lena_quan64');

lena_quan = dos2im_quan('lena_quan64');