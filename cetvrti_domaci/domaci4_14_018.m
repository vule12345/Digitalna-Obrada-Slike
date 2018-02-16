% OE4DOS Forth assignment 1/2018
% Student : Vuk Vukomanovic 2014/0018
% This script contains all sub tasks
% Assigment : http://tnt.etf.rs/~oe4dos/Domaci_zadaci/dos1718_domaci4.pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc
%% First task, LANE DETECTION
% Wraper function was used for this

lane_detection_wrapper('videos/video1.mpeg')

%% Second task, CELL COUNTING

cells1 = imread('cells/cells1.jpg');
disp(count_cells(cells1));

cells2 = imread('cells/cells2.jpg');
disp(count_cells(cells2));

cells3 = imread('cells/cells3.jpg');
disp(count_cells(cells3));

cells4 = imread('cells/cells4.jpg');
disp(count_cells(cells4));

cells5 = imread('cells/cells5.jpg');
disp(count_cells(cells5));

cells6 = imread('cells/cells6.jpg');
disp(count_cells(cells6));

cells7 = imread('cells/cells7.jpg');
disp(count_cells(cells7));


%% Third task, CANNY EDGE DETECTIOn

lena = imread('edge/lena.tif');

camerman = imread('edge/camerman.tif');

house = imread('edge/house.tif');

van = imread('edge/van.tif');

lena_edge = canny_edge_detection(lena, 1.4, 0.1, 0.075 );

cameraman_edge = canny_edge_detection(camerman, 2.5, 0.15, 0.1);

house_edge = canny_edge_detection(house, 1.4, 0.15, 0.1);

van_edge = canny_edge_detection(van, 1.5, 0.15, 0.1);

figure
imshow(lena_edge);

figure
imshow(cameraman_edge);

figure
imshow(house_edge);

figure
imshow(van_edge);
