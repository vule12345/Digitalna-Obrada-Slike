function output = canny_edge_detection( input, sigma, Th, Tl)
%CANNY_EDGE_DETECTION  Find edges in intensity image.
%   Function takes intesity image input and usses Canny method for edge
%   detection. Sigma is value for gaussian filter, and Th and Tl are high
%   treshold and low treshold respectively.
%------
% Input
%   input -  intesity image
%   Th    - treshold high
%   Tl    - treshold low
%   sigma - sigma for gaussian
%-------
% Example
%
%
%   B = CANNY_EDGE_DETECTION(LENA, 0.4, 0.1, 1);
%

input = mat2gray(input);

% Get size of input image
[M, N] =  size(input);

% Calculate next odd number to 6 sigma for width of Gaussian filter
gaussian_N = ceil(6*sigma);
gaussian_N = gaussian_N + (1 - mod(gaussian_N,2));

% Gaussian filter with specifed parametars
filtar = fspecial('gaussian', gaussian_N, sigma);

% Appyling Gaussian filter
input_filtered = imfilter(input , filtar,'replicate');

% Sobel gradients
% Horiznotal
Hx = [-1 -2 -1;0 0 0;1 2 1];

% Vertical
Hy = Hx';

% Appyling gradients
g_x = imfilter(input_filtered, Hx, 'replicate', 'same'); 
g_y = imfilter(input_filtered, Hy, 'replicate', 'same');

% Calculating magnitude
Mag = (g_x.^2+ g_y.^2).^0.5;

% Calculatng angles
alfa = atan(g_y./g_x);

% Quantization of gradient

% Horizontal
alfa((alfa >= -pi/8) & (alfa < pi/8)) = 0;

% Diagonal -45
alfa((alfa >= pi/8) & (alfa < 3*pi/8)) = -45;

% Vertical
alfa((alfa >= 3*pi/8) & (alfa <= pi/2)) = 90;

% Diagonal 45
alfa((alfa >= -3*pi/8) & (alfa < -pi/8)) = 45;

% Vertical
alfa((alfa >= -pi/2) & (alfa < -3*pi/8)) = 90;

% Alocating matrix
Mag_supressed = zeros(M, N);


% Supressing non-local maximas
for i = 2:M-1
    for j = 2:N-1
        if (alfa(i,j)==0)
            if ((Mag(i, j)>= Mag(i-1, j)) && (Mag(i,j)>= Mag(i+1, j)))
                Mag_supressed(i,j) = 1;
            end
            
        elseif (alfa(i,j)== -45)  
            if ((Mag(i,j)>= Mag(i-1, j-1)) && (Mag(i,j) >= Mag(i+1, j+1)))
                Mag_supressed(i,j) = 1;
            end
            
        elseif (alfa(i,j)== 45)                 
            if ((Mag(i, j)>= Mag(i-1, j+1)) && (Mag(i, j)>= Mag(i+1, j-1)))
                Mag_supressed(i,j) = 1;
            end
            
        else                       
            if ((Mag(i, j)>= Mag(i, j-1)) && (Mag(i,j)>= Mag(i, j+1)))
                Mag_supressed(i,j) = 1;
            end           
        end       
    end
end


% All edge candidates 
edge_canditates = Mag.*Mag_supressed;

% Just strong edges
edges_strong = edge_canditates > Th;

% Strong and weak edges
edges_both = edge_canditates > Tl;

% Just weak edges
edges_weak = edges_both - edges_strong;


% Processing weak edges that are connected to some strong one
% If weak edge becomes strong, all weak one connect to her must be
% reprocessed

% Buffers
edge_buffer_current = edges_strong;
edge_bugger_previous = edges_weak;


while(1)
for i = 2:M-1
    for j = 2:N-1
        if (edge_bugger_previous(i,j) == 1)
            neighbourhood = edge_buffer_current(i-1:i+1,j-1:j+1);
            % Checking if there is any strong edge in neighbourhood
            if (mean(neighbourhood(:))>0)
                edge_buffer_current(i,j) = 1;
            end
        end
    end
end

% If there is no change end loop
if(isequal(edge_buffer_current, edge_bugger_previous)==1)
    break;
end

edge_bugger_previous = edge_buffer_current;

end

output = edge_buffer_current;

end

