clear
clc
close all

% Creating video reader object
video_handler =  VideoReader('videos/video1.mpeg');

% Creating output video
outputVideo =VideoWriter('out');

% Setting same frame rate as input video
outputVideo.FrameRate = video_handler.FrameRate;

% Open output video for writing
open(outputVideo);
    
% Loop for all frames in video
while hasFrame(video_handler)

% Read current frame from input video
frame = readFrame(video_handler);

% Create mask of yellow pixels
yellow_mask = createMask_yellow(frame);

% Create mask of white pixels
white_mask = createMask_white(frame);

% Create combinated mask of yellow and white pixels
mask = yellow_mask | white_mask;
mask3 = cat(3, mask, mask, mask);

% Filtering yellow and white pixels from current frame
color_filtered = frame;
color_filtered(imcomplement(mask3)) = 0;

% Appyliyng small gaussian filter for image blurring
color_filtered = imgaussfilt3(color_filtered,2);

% Converting image to gray, so morphological operations can be applied
gray = rgb2gray(color_filtered);

% Square morph element
SE = strel('square', 5);

% Morphological opening
gray= imopen(gray,SE);

% Canny edge detection
edges = edge(gray,'Canny');

% Loading region of interest mask
load roi.mat

% Applying region of interest mask to edge image 
edges_roi = edges.*roi;

% Appliying Hough transformation 
[H,T,R] = hough(edges_roi);

% Finding 20 peaks and tresholding them
P = houghpeaks(H, 20, 'Threshold', 0.2*max(H(:)));

% Finding lines that are bigger than 15 and with gap smaller than 20 
hough_lines = houghlines(edges_roi,T,R,P, 'FillGap',20,'MinLength',15);

% Hellper max variables
max_first=-Inf;
max_second=-Inf;

lines = hough_lines;

% Looping thourgh all found lines
for i=1:length(hough_lines)

% Calculating length of current line
len = norm(lines(i).point1 - lines(i).point2);
   
% If orientation of line does not fit our possble angles we skip them
if(abs(hough_lines(i).theta) > 65 | abs(hough_lines(i).theta) < 50)
    continue;
end

% Detecting line with positive theta(left or right)
% and finding maximum of those lanes
if(hough_lines(i).theta > 0)
    if(len > max_first)
        max_first = len;
        leva_point1 = lines(i).point1;
        leva_point2 = lines(i).point2;
    end
end
    
% Detecting line with negative theta(left or right)
% and finding maximum of those lanes
if(hough_lines(i).theta < 0)
    if(len > max_second)
        max_second = len;
        desna_point1 = lines(i).point1;
        desna_point2 = lines(i).point2;
    end
end 
end
    
% Hardcodded values for line beginings
x_start = 680;
x_end  = 470;


% Fitting points onto 2 lines
x_points_first = [leva_point1(1), leva_point2(1)];
y_points_first = [leva_point1(2), leva_point2(2)];

% Coefficients of first line
coeffs_first = polyfit(y_points_first, x_points_first, 1);

% Calculating points from fitted coeffs and starting and ending x point
bot_left = [coeffs_first(1)*x_start+coeffs_first(2) x_start];
top_left =[coeffs_first(1)*x_end+coeffs_first(2) x_end];

test_draw1 = frame;

test_draw1 = insertShape(test_draw1,'Line',[bot_left top_left] ,'LineWidth',15,'Color','red','Opacity',0.2);

% Fitting points ontto line
x_points_second = [desna_point1(1), desna_point2(1)];
y_points_second = [desna_point1(2), desna_point2(2)];

% Coefficients of second line
coeffs_second = polyfit(y_points_second, x_points_second, 1);

% Calculating points from fitted coeffs and starting and ending x point
bot_rigt = [coeffs_second(1)*x_start+coeffs_second(2) x_start];
top_right =[coeffs_second(1)*x_end+coeffs_second(2) x_end];

test_draw1 = insertShape(test_draw1,'Line',[bot_rigt top_right] ,'LineWidth',15,'Color','red', 'Opacity',0.2);

writeVideo(outputVideo,test_draw1);

close all
imshow(test_draw1);

end


close(outputVideo);


figure, imshow(frame), hold on
xy = [leva_point1; leva_point2];
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

xy = [desna_point1; desna_point2];
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

lines =hough_lines;
I=frame;

figure, imshow(I), hold on
for k= 1:length(lines)
    
xy = [lines(k).point1; lines(k).point2];
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% plot beginnings and ends of lines
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end
hold off;

