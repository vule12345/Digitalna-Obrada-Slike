clear
close all
clc
tic
img  = im2double(imread('ulazne_slike/lena_noise.tif'));

S = 15;
K = 3;
variance = 0.007;
h = 0.05;

% Size of image
[M, N] =  size(img);

% Dimenison for padding the input image
half_s = floor(S/2);
half_K = floor(K/2);
pad = half_s + half_K;

% Padd input image
padded_img = padarray(img,[pad, pad],'symmetric', 'both');

%Alocating new image
output_image = zeros(M, N);

% Weight function
weight = zeros(1,S^2);

%First 2 fors loop through whole image and for any pixel calculate output
%value
% Global loop for x
for global_x = pad+1: pad+M
    
    % Global loop for y
    for global_y = pad+1: pad+N
      
        % Calculate KxK neighborhood around current pixel (global_x,
        % global_x)
        ref_KxK = padded_img (global_x - half_K: global_x + half_K, global_y - half_K :global_y + half_K);
               
        % Starting coordinates of KxK neighborhood around current pixel, which is
        % -K/2 in both directions. Top left pixel.
        K_begin_x = global_x - half_K;
        K_begin_y = global_y - half_K;
        
        % Coordinates of SxS search neighborhood around current pixel, which is
        % +-S/2 in both directions
        SxS_begin_x = global_x - half_s;
        SxS_begin_y = global_y - half_s;
        SxS_end_x = global_x + half_s;
        SxS_end_y = global_y + half_s;
        
        %  Prealocating Euclidian variable for speed.
        %  It's size will be SxS because there are that many pixels in
        %  search region.
        distance = zeros(S,S);
        
        % For loops which are used to go through all KxK neighborhoods in
        % search region.
        % In every passing of the loops, Euclidian distance for one pixel from current pixel neighborhood
        % will be calculted with corresponding pixels in all neighborhoods
        % in search region.
        for K_x = 0: K-1 
            for K_y = 0 : K-1
                
                % X indices for all corresponding pixels in KxK
                % neighborhood to pixel (global_x-K/2+K_x, Global_y-K2)
                % Size of this variable is 1xS
                verctical_indices = SxS_begin_x - half_K + K_x: SxS_end_x - half_K + K_x;
               
                
                % Y indices for all corresponding pixels in KxK
                % neighborhood to pixel (global_x-K/2+K_x, Global_y-K2)
                % Size of this variable is 1xS
                horizontal_indices = SxS_begin_y-half_K + K_y: SxS_end_y - half_K + K_y;
                
                % Using determined indices to access pixel and cacluate
                % Euclidan distance. Since we need the sum every time the
                % values are added to corresponding places.
                % Size of this variable is SxS
                distance = distance + (padded_img(K_begin_x + K_x, K_begin_y + K_y) - padded_img(verctical_indices, horizontal_indices)).^2;
                
            end    
        end
      
        % Normalizing Euclidan distance sum
        distance = (double(distance)/(K*K));
        
        % Calculating exponential weight funcition
        numerator = max(distance - 2*variance, 0);
        weight =  double(exp(-numerator/(h^2)));
        
        % Variable used for normalizing weight functions
        Z = sum(sum(weight));
        
        % Assigning values to pixels in new image
        weighted_pixels = padded_img(SxS_begin_x : SxS_end_x, SxS_begin_y:SxS_end_y) .* weight;
        output_image(global_x-pad, global_y-pad) = (1/Z)*sum(sum(weighted_pixels));
        
    end
end




toc



































