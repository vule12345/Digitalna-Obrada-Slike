function lane_detection_wrapper( video_path )
%LANE_DETECTION_WRAPPER Wrapper function for lane detection.
%   Function takes path to input video and saves result to out.avi file.

% Creating video reader object
video_handler =  VideoReader(video_path);

% Creating outputvide
outputVideo =VideoWriter('out');

% Setting same frame rate as input video
outputVideo.FrameRate = video_handler.FrameRate;

% Open output video for writing
open(outputVideo);
ais=0;

% Loop for all frames in video
while hasFrame(video_handler)
ais=ais+1;
% Read current frame from input video
frame = readFrame(video_handler);


% Find road lanes in image
[first, second] = lane_detection(frame);

% if(ais > 1004)
%     disp('asd');
% end

if(ais >1)
    first = (previous_first + first)/2;
    second = (previous_second*0.6 + 0.4*second);
end

% Dummy frame for drawing lines
test_draw1 = frame;

% Inserting first line in frame
test_draw1 = insertShape(test_draw1,'Line', first,'LineWidth',15,'Color','red','Opacity',0.2);

% Inserting second line in frame
test_draw1 = insertShape(test_draw1,'Line', second,'LineWidth',15,'Color','red', 'Opacity',0.2);

% Writing to output video
writeVideo(outputVideo,test_draw1);

previous_first = first;
previous_second = second;


end

% Closing video object
close(outputVideo);
end

