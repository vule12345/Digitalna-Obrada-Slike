function cell_count = count_cells( cells )
%COUNT_CELLS counts number of cells in given image

% Resizing image to average size of images from test set
celije_dim = imresize(cells, [640 820]);

% Converting image to gray, becuse detection should be color invariant
gray = mat2gray(rgb2gray(celije_dim));

% Thresholding image with 2 levels 
level = multithresh(gray,2);

% Appliing tresholds
seg_I = imquantize(gray,level);

% Image with only nukleus
nukleus= seg_I;

% Image with only citoplasm
citoplasm = seg_I;

% Nukeleus bw image creation
nukleus(seg_I==2)=0;
nukleus(seg_I==1)=1;
nukleus(seg_I==3)=0;

% Citoplasm bw imag creation
citoplasm(seg_I==2)=0;
citoplasm(seg_I==1)=0;
citoplasm(seg_I==3)=1;

% Structuring element for morphological operations
se = strel('disk',3);

% Morphopolgical opening
morph_bw = imopen(nukleus,se);


[~, cell_count] = bwlabeln(morph_bw, 8);


end

