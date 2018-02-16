%% Skripta koja kombinuje metode sa Laplasijanom i gradijentom. Ova metoda
% je opisana u knjizi Digital image processing (Gonazles). Ideja je da se
% iskoriste prednosti obe metode. Tj. odziv laplasijana ce biti pun suma,
% dok odziv metode sa gradijentom ce imati dosta manje, naravno gradijent
% upravo zbog toga gubi dosta informacija. Ideja je da se kombinovanje ove
% dve metode napravi kvalitenija slika.

%Note: Ovaj fajl odstupa od komentara na engleskom

close all
clear 
clc

% Input image
lange = double(imread('ulazne_slike/lange.jpg'));
figure
imshow(lange/255);
set(gcf, 'Name', 'Ulazna slika, lange');
title('Ulazna slika, lange','Interpreter','LaTex','FontSize',16),grid on

a=mat2gray(lange);

% Koriscenje laplaciana za dobijanje pojacanih ivica
laplacian_mask =  [0 1 0; 1 -4 1; 0 1 0];
laplacian_res = mat2gray( imfilter(a, laplacian_mask, 'replicate'));
lange_ench = mat2gray(a + laplacian_res);
figure
imshow(laplacian_res,[]);
set(gcf, 'Name', 'Laplacian filter');
figure
imshow(lange_ench,[]);
set(gcf, 'Name', 'Sabrano');

% Koriscenje sobel gradienta
sobel = [-1 -2 -1; 0 0 0; 1 2 1];
gradient =  imfilter(a, sobel, 'replicate');
figure
imshow(gradient, []);
set(gcf, 'Name', 'Sobel gradient');

% Usrednjavanje prehtodnoh rezultata
low_pass_mask = fspecial('average',20);
smoothed_gradient = mat2gray(imfilter(gradient,low_pass_mask,'replicate'));
figure
imshow(smoothed_gradient,[]);
set(gcf, 'Name', 'Smoothed Gradient');

%Koriscenje maske
mask_multiplied = mat2gray(lange_ench.*smoothed_gradient);

figure
imshow(mask_multiplied,[]);
set(gcf, 'Name', 'Nakon primene maske');

final= mat2gray(a+mask_multiplied);
figure
imshow(final, []);
set(gcf, 'Name', 'final');


