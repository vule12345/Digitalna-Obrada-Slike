clear all
close all
clc

%Input slike
gray_img = imread('ulazne_slike/dark.tif');
specifed_img = imread('ulazne_slike/lange.jpg');

ekvi_img = gray_img;
spec_img = gray_img;

%Specifirani histogram
specifed_hist = imhist(specifed_img);

%Verovatnoce ulazne slike
P_r = (imhist(gray_img)/numel(gray_img));

%S_kovi ekvilizrane slike
Sk = round(cumsum(P_r)*255);


%Specificne histograma
P_z = specifed_hist/numel(specifed_img);
Gz = round(cumsum(P_z)*255);

%Slika sa ekvivzarnim histogramom
for value= 1: 255
    ekvi_img(gray_img==value) = Sk(value);
end

%Racuanje z parametra
z = zeros(1,255);
 for in= 1 : 255
    [dummy z(in)] = min(abs(Gz-Sk(in)));    
 end
 
 %Finalno mapiranje 
 for value= 1: 255
    spec_img(gray_img==value) = z(value);
 end
 
 
 
figure
bar(imhist(gray_img))

figure
bar(imhist(specifed_img))

figure
bar(imhist(spec_img))



 