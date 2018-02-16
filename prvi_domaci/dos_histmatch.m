function output = dos_histmatch(varargin)
%DOS_HISTMATCH Adjust 2-D or 3-D image to match its histogram to that of
%another image
%   B = DOS_HISTMATCH(I) transforms the input grayscale or truecolor
%   image A so that the histogram of the output image B is approximetaly
%   equalized. For truecolor images, each color channel of A is equlized 
%   independently. Default value for bit_depth is 8.
%
%   B = DOS_HISTMATCH(I,R) transforms the input grayscale or truecolor
%   image A so that the histogram of the output image approximetaly
%   matches the histogram of the reference image R. For truecolor images,
%   each color channel of A is matched independently to the corresponding
%   color channel of R. If R is grayscale each channel of A is matched to 
%   same R. Default value for bit_depth is 8.
%
%   B = DOS_HISTMATCH(I,R, bit_depth) uses bit_depth bits to calculate
%   intesities of output image.
% 
%   Class Support
%   -------------
%   I can be double with intesity values from range [0,1]. The output image
%   B has the same class as I. Bit_depth argument is of class uint8 with 
%   valuse from 1 to 16;
% 
%   Example
%   -------
%   This example matches the histogram of one image to that of another image
%   with default of 8 bits for calculations.
%        
%        I = imread('dark.tif');
%        imshow(A, []);
%        title('Original Image');
%  
%        R = imread('original1.png');
%        figure, imshow(ref, []);
%        title('Reference Image');
%  
%        B = imhistmatch(A, R);
%        figure
%        bar(imhist(I));
%        set(gcf, 'Name', 'Histogram of input image');
%
%        figure
%        bar(imhist(R))
%        set(gcf, 'Name', 'Histogram of reference image');
%
%        figure
%        bar(imshit(B))
%        set(gcf, 'Name', 'Histogram of output image');
% 
%--------------------------------------------------------------------------

    % Parsing and checking input arguments
    % Checking if enough or too much arugments are given
    narginchk(1,3);
    
    % Taking first argument
    I = varargin{1};
    [M, N, I_d] =  size(I);
    
    % Validating that input image is in specifed format
    validateattributes(I, {'double'}, {'>=',0,'<=',1})
    
    % Default value for argument bit_depth
    bit_depth =8;
    
    % Checking if there is second argument 
    if(nargin > 1)
        R = varargin{2};
        % Checking if refernce image is in specifed format
        validateattributes(R, {'double'}, {'>=',0,'<=',1})
        
        % Checking if dimenions of  input and refenrce image are correct
        [~, ~, R_d] =  size(R);
        
        if(I_d ~=1 && I_d~=3)
            error('Input image is not 2-D or 3-D')
        end
        if(R_d ~=1 && R_d~=3)
            error('Reference image is not 2-D or 3-D')
        end
        if(I_d ==1 && R_d~=1)
           error('Input and refernce image dimension do not agree is')
        end
        
    end
    
    % Checking if there is third argument 
    if(nargin == 3)
        bit_depth = varargin{3};
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Appliying histogram matching to channels of image
   
    % Allocating output image
    output = zeros(M, N, I_d); 
    
    % Generating output based on input images using histmatch helper
    % function
    if(nargin == 1) 
        
        if(I_d == 1)
           % If image is 2-D and there is no reference image
           % just equalize histogram of input image
           output = histmatch_helpler(I);
        else 
           % If image is 3-D and there is no reference image
           % just equalize histograms of all chanlles of input image
            output(:,:,1) = histmatch_helpler(I(:,:,1));
            output(:,:,2) = histmatch_helpler(I(:,:,2));
            output(:,:,3) = histmatch_helpler(I(:,:,3));
        end
    else
        if(I_d == 1)
            % If image is 2-d and there is reference image
            % apply hisogram matching 
              output = histmatch_helpler(I, R, bit_depth);
        else 
            if(R_d == 1)
                % If image is 3-d and there is 2-D reference image
                %  pply histogram matching for every chanell of input image
                output(:,:,1) = histmatch_helpler(I(:,:,1), R, bit_depth);
                output(:,:,2) = histmatch_helpler(I(:,:,2), R, bit_depth);
                output(:,:,3) = histmatch_helpler(I(:,:,3), R, bit_depth);
            else
                % If image is 3-d and there is 3-D reference image 
                % apply histogram matching between corresponding chanells 
                output(:,:,1) = histmatch_helpler(I(:,:,1), R(:,:,1), bit_depth);
                output(:,:,2) = histmatch_helpler(I(:,:,2), R(:,:,2), bit_depth);
                output(:,:,3) = histmatch_helpler(I(:,:,3), R(:,:,3), bit_depth);
            end
        end
    end
    
 
end







