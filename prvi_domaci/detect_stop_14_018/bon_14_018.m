% OE4DOS First homework 11/12/2017
% Student : Vuk Vukomanovic 2014/0018
% This script contains bonus task
%Assigment : http://tnt.etf.rs/~oe4dos/Domaci_zadaci/dos1718_domaci1.pdf
close all
clc
clear

warning('off', 'images:initSize:adjustingMag')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Sometis function mark stop malfunctions if called n times in row, this
%%will overlay some image's green stop rectangles.


% Read all images
stop1  = imread ('bonus/stop1.jpg');
stop2  = imread ('bonus/stop2.JPG');
stop3  = imread ('bonus/stop3.jpg');
stop4  = imread ('bonus/stop4.jpg');
stop5  = imread ('bonus/stop5.jpg');
stop6  = imread ('bonus/stop6.jpg');
stop7  = imread ('bonus/stop7.jpg');
stop8  = imread ('bonus/stop8.JPG');

% Call first method
% res1_1 = detect_stop_1(stop1);
% mark_stop(stop1,res1_1);
% 
% res1_2 = detect_stop_1(stop2);
% mark_stop(stop2,res1_2);
% 
% res1_3 = detect_stop_1(stop3);
% mark_stop(stop3,res1_3);
% 
% res1_4 = detect_stop_1(stop4);
% mark_stop(stop4,res1_4);
% 
% res1_5 = detect_stop_1(stop5);
% mark_stop(stop5,res1_5);
% 
% res1_6 = detect_stop_1(stop6);
% mark_stop(stop6,res1_6);
% 
% res1_7 = detect_stop_1(stop7);
% mark_stop(stop7,res1_7);
% 
% res1_8 = detect_stop_1(stop8);
% mark_stop(stop8,res1_8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call second method
res2_1 = detect_stop_2(stop1);
mark_stop(stop1,res2_1);

res2_2 = detect_stop_2(stop2);
mark_stop(stop2,res2_2);

res2_3 = detect_stop_2(stop3);
mark_stop(stop3,res2_3);

res2_4 = detect_stop_2(stop4);
mark_stop(stop4,res2_4);

res2_5 = detect_stop_2(stop5);
mark_stop(stop5,res2_5);

res2_6 = detect_stop_2(stop6);
mark_stop(stop6,res2_6);

res2_7 = detect_stop_2(stop7);
mark_stop(stop7,res2_7);

res2_8 = detect_stop_2(stop8);
mark_stop(stop8,res2_8);
