function output = dos_downscale(I, s)
%DOS_DOWNSCALE Decimate input image by factor s
%   B = dos_downscale(I,s) resizes input image I by factor s.

scale_factor = s;

% Filtering image to prevent anti-aliasing
input = double(I);

% Size of input image
[old_M, old_N] = size(input);

% Size for caclulating 
P = 2*old_M-1; Q = 2*old_N-1;

% Spectrum of input image
input_spectrum = fftshift(fft2(input, P, Q));

% Low pass filter
D0 = max(old_M,old_N)*(scale_factor)/2;
H = lpfilter('gaussian', P, Q, D0);
H = fftshift(H);

% Convolution
Gp = input_spectrum.*H;

% Back to spatial domain
input = ifft2(ifftshift(Gp));

% Calculating size of new image
new_M = floor(scale_factor*old_M);
new_N = floor(scale_factor*old_N);

% Allocating memory of output image
output = zeros(new_M, new_N);

% Indices of new scaled image
new_rows = (1:new_M);
new_columns = (1:new_N);

% Calculating nearest indices to original image
old_rows = round( (new_rows-1)*(old_M-1)/(scale_factor*old_M-1)+1 );
old_columns = round( (new_columns-1)*(old_N-1)/(scale_factor*old_N-1)+1 );

% Applying 
output(new_rows,new_columns) = input(old_rows,old_columns);


end

