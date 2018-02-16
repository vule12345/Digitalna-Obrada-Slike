%clear 
close all
clc

%Izbrisi ov
bit_depth = 8;

argument_flag = 0;

original1 = mat2gray(dark);
% Reading input image and image with wanted histogram
I = original1;%imread('ulazne_slike/dark.tif');
R = original1;%imread('ulazne_slike/lange.jpg');

%Funkcija na dole
depth = 2^bit_depth -1;

% Dimensions of input image
[M,N] = size(I);

% Scaling images for easier manipulation
I = uint16(round(double(I*depth)));
R = uint16(round(double(R*depth)));

% Specifed histogram calculation
specifed_hist = custom_histogram(R, depth);

% Input image histogram calculation.
input_hist = custom_histogram(I, depth);

% Calculating probability of occurrences of intesity levels in input hist
P_r = input_hist ./ numel(I);

% Histogram equalization
% In this step we have trasnfer function for historam equalization
Sk = round(cumsum(P_r)*depth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If there is not second argument in funcion, it should only eqilize
%histogram

if(argument_flag == 1 | argument_flag ==0)
    equalizated_image = zeros(M,N);
    for value= 1: depth
        equalizated_image(I==value) = Sk(value);
    end
%return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculating probability of occurrences of intesity levels in output hist
P_z = specifed_hist/numel(R);

% Calculating transfer funciton
Gz = round(cumsum(P_z)*depth);

% Finding nearest sk to Gz and assigning it to z 
z = zeros(1,depth);
for in= 1 : depth
    [dummy,z(in)] = min(abs(Gz-Sk(in)));    
end

% Final mapping from s->z 
result_image = zeros(M,N);
 for value= 1: depth
    result_image(I==value) = z(value);
 end
 
%




