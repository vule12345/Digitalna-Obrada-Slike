% OE4DOS Third assignment 12/2017
% Student : Vuk Vukomanovic 2014/0018
% This script contains all sub tasks
% Assigment : http://tnt.etf.rs/~oe4dos/Domaci_zadaci/dos1718_domaci3.pdf
clear
clc
close all
warning('off', 'images:initSize:adjustingMag')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Report holds explanations of why certain method were used

%%% 1-3. Huffman coding testing
disp('Prvi deo domaceg')
% Testing Hufmans coding for matrix F
load F
encoded_F = encode_huffman(F);
decoded_F = decode_huffman(encoded_F);
disp('Da li je dekodovana matrica  F jednaka ulaznoj')
disp(isequal(decoded_F, F))

% Testing Hufmans coding for matrik K
load K
encoded_K = encode_huffman(K);
decoded_K = decode_huffman(encoded_K);
disp('Da li je dekodovana matrica  K jednaka ulaznoj')
disp(isequal(decoded_K, K))
disp('-------------------------');

%%% 4-6. Compression functions testing
disp('Drugi deo domaceg');
lena = imread('lena.tif');

% Quality = 1
tic
im2dos(lena, 1, 'lena_com_1');
lena_1 = dos2im('lena_com_1');
disp('Vreme za quality=1');
toc
lena_1_psnr = psnr(lena, lena_1);
disp('Quality=1')
disp('PSNR')
disp(lena_1_psnr);
figure; 
imshow(lena_1);
set(gcf, 'Name', 'lena, quality=1');
disp('-------------------------');

% Quality = 7
tic
im2dos(lena, 7, 'lena_com_7');
lena_7 = dos2im('lena_com_7');
disp('Vreme za quality=7');
toc
lena_7_psnr = psnr(lena, lena_7);
disp('Quality=7')
disp('PSNR')
disp(lena_7_psnr);
figure; 
imshow(lena_7);
set(gcf, 'Name', 'lena, quality=7');
disp('-------------------------');

% Quality = 15
tic
im2dos(lena, 15, 'lena_com_15');
lena_15 = dos2im('lena_com_15');
disp('Vreme za quality = 15');
toc
lena_15_psnr = psnr(lena, lena_15);
disp('Quality = 15')
disp('PSNR')
disp(lena_15_psnr);
figure; 
imshow(lena_15);
set(gcf, 'Name', 'lena, quality=15');
disp('-------------------------');

% Quality = 33
tic
im2dos(lena, 33, 'lena_com_33');
lena_33 = dos2im('lena_com_33');
disp('Vreme za quality = 33');
toc
lena_33_psnr = psnr(lena, lena_33);
disp('Quality = 33')
disp('PSNR')
disp(lena_33_psnr);
figure
imshow(lena_33);
set(gcf, 'Name', 'lena, quality=33');
disp('-------------------------');

% Quality = 64
tic
im2dos(lena, 64, 'lena_com_64');
lena_64 = dos2im('lena_com_64');
disp('Vreme za quality = 64');
toc
lena_64_psnr = psnr(lena, lena_64);
disp('Quality = 64')
disp('PSNR')
disp(lena_64_psnr);
figure
imshow(lena_64);
set(gcf, 'Name', 'lena, quality=64');
disp('-------------------------')
disp('Kraj domaceg')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing without quantization