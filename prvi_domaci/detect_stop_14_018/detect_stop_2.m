function map = detect_stop_2( stop )
%DETECT_STOP Find stop sign on given image
% Input image stop is RGB image.

% Get dimensions of image
[M, N , ~] = size(stop);

% Convert from rgb to gray
stop_gray = rgb2gray(stop);

% Extract red pixels
red_extracted = (imsubtract(stop(:,:,1), stop_gray));

% Binarize image
binarized = imbinarize(red_extracted);

% Call function region_props
% Workings of regionprops are explained in report
regions = regionprops(binarized, 'all');

% Get region with max pixles in it
[~, bigest_index] = max([regions.Area]); 

% Create empty map
map = zeros(M,N);

% Assign 1 to all pixels from maximum region
map(regions(bigest_index).PixelIdxList)=1;

end

