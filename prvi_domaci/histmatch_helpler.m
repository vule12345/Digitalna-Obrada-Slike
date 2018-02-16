function output_image = histmatch_helpler(varargin)
%HISTMATCH_HELPER Adjust 2-D image to match its histogram to that of
%another image
%This funcions is only used in dos_histmatch and it is intended for it to
%be private functon.

% Note : vode was time optimazed, hence there is only one for loop which
% stayed in code instead of intloop function.

% Checking number of arguments and setting variables accordingly.
if(nargin > 1)
    R = varargin{2};
    bit_depth = varargin{3};
    argument_flag = 0;
else
    R = 0;
    bit_depth = 8;
    argument_flag = 1;
end

% Assignin first argument to I
I = varargin{1};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%SMART STUFF starts here :)
% Maximum intesinty level
depth = 2^bit_depth -1;

% Dimensions of input image
[M,N] = size(I);

% Scaling input image for easier manipulation
I = uint16(round(double(I*depth)));

% Input image histogram calculation.
input_hist = custom_histogram(I, depth);

% Calculating probability of occurrences of intesity levels in input
% histogram
probabilities = input_hist ./ numel(I);

% Histogram equalization
% In this step we have transfer function for historam equalization
Sk = (cumsum(probabilities)*depth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If there is not second argument in funcion, it should only eqailize
%histogram

if(argument_flag == 1)
%     for value= 0: depth
%         output_image(I==value) =  mat2gray(double(Sk(value+1)/depth));
%     end
    output_image = Sk(double(I)+1)/depth;
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Scaling reference image for easier manipulation
R = uint16(round(double(R*depth)));

% Specifed histogram calculation
specifed_hist = custom_histogram(R, depth);

% Calculating probability of occurrences of intesity levels in output hist
P_z = specifed_hist/numel(R);

% Calculating transfer funciton
Gz = round(cumsum(P_z)*depth);

% Finding nearest sk to Gz and assigning it to z 
z = zeros(1,depth);
for idx= 1 : depth+1
    [~, ind] = min(abs(Gz-Sk(idx)));  
    z(idx) = ind -1; 
end

output_image = z(double(I)+1)/depth;

% This last for loop could be avoided if we used function intlut. But
% because of the way this fucntion work bit_depth paramter could not be
% every number from 0 to 15


