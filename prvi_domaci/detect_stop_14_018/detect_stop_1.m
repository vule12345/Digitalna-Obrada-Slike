function map = detect_stop_1( stop )
%DETECT_STOP Find stop sign on given image
% Input image stop is RGB image.

% Convert image to grayscale
stop_gray = rgb2gray(stop);

% Extract only red pixels on image
red_extracted = (imsubtract(stop(:,:,1), rgb2gray(stop)));

% Binarize image
binarized = imbinarize(red_extracted);

% Remove all objects smaller than 500 pixees, this step is not necessary
%but function works better, how this funcions work is same as how region 
%props works in report
binarized = bwareaopen(binarized,500);

% Find cooradinates of white pixels
[x_red, y_red] = find(binarized ==1);
red = [x_red, y_red];


% Find coordinates of white pixels on image
[x_white, y_white] = find(stop_gray>200);
white = [x_white, y_white];


% Specify transtion from white to red pixels  
coeff = 4;
maybe_x = x_red-coeff;
maybe_y = y_red;
maybe = [maybe_x, maybe_y];

% Find white pixels which are left from red pixels
sign_part = intersect(maybe, white, 'rows', 'stable');
x_part_sign = sign_part(:,1)+coeff;
y_part_sign = sign_part(:,2);

% Call flood fill on previusly calculated parts of stop sign
map = imfill(binarized,[x_part_sign,y_part_sign]);

end

