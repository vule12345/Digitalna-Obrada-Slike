% OE4DOS Second bonus assignment 11/2017
% Student : Vuk Vukomanovic 2014/0018
% This script contains all sub tasks
% Assigment : http://tnt.etf.rs/~oe4dos/Domaci_zadaci/dos1718_domaci2.pdf
clear
clc
close all
warning('off', 'images:initSize:adjustingMag')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Report holds explanations of why certain method were used


% Baby slika
M=1280;
N= 720  ;

%Filtering baby images
collection = zeros(M, N, 9);
for i=1 : 9
    
   format = ['Baby/' int2str(i) '.jpg']; 
   collection(: ,:,i) = rgb2gray(imread(format));
    
end

collection  = mat2gray(collection);

baby_filtered = dos_mfnr_gray_1(collection, 5, 0.1);
imshow(baby_filtered);


% % Portrait slika
% M=1200;
% N= 1600  ;
% 
% %Filtering baby images
% collection = zeros(M, N, 9);
% for i=1 : 9
%     
%    format = ['Portrait_1/' int2str(i) '.JPG']; 
%    collection(: ,:,i) = rgb2gray(imread(format));
%     
% end
% 
% collection  = mat2gray(collection);
% 
% portrait_filtered = dos_mfnr_gray_1(collection, 5, 0.1);
% imshow(portrait_filtered);


% % Portrait slika
% M=1850;
% N= 2456;
% 
% %Filtering baby images
% collection = zeros(M, N, 9);
% for i=1 : 9
%     
%    format = ['Bookshelf_1/' int2str(i) '.jpg']; 
%    collection(: ,:,i) = rgb2gray(imread(format));
%     
% end
% 
% collection  = mat2gray(collection);
% 
% book_self_filtered = dos_mfnr_gray_1(collection, 5, 0.1);
% imshow(book_self_filtered);