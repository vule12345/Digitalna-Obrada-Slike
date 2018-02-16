function fixed_image = fix_corrupted( corrupted_image , display)
%fix_corrupted Fixes grayscales image with pre defined distorsions
%   B = fix_corrupted(A) transfroms the input grayscale image so that all
%   predefined distortions are removed. Output B is also grayscale image
%   with intensity of pixels [0,255].
%
%   B = fix_corrupted(A,'on') transfroms the input grayscale image so that all
%   predefined distortions are removed. Second parametar specifes if image
%   and all of it's steps will imshow in separate window. Defaul value of
%   display is 'off'
%
%   Example
% ----------
%   B = fix_corrupted(A,'on')

if ~exist('display','var')
     % Third parameter does not exist, so default it to something
      display = 42;
end


% Removing salt and papper noise with median filter;
impluse_noise_removed = medfilt2(corrupted_image, [3 3], 'symmetric');

% Making negative of filtered image
negative  = 255 - impluse_noise_removed;

% High pass filtering
low_pass_mask = fspecial('average', 5);
low_pass_response = imfilter(double(negative), low_pass_mask,'replicate');
high_pas_componetnt = double(negative) - low_pass_response;
negative_filtered = uint8(double(negative) + high_pas_componetnt);
negative_filtered = mat2gray(negative_filtered);

% Enhance contrast of sharpend image
contrast_enhanced = uint8(imadjust(negative_filtered,[24 228]/255,[0 243]/255,1.2)*255);

fixed_image = contrast_enhanced;

% If display options is on, show all results
if(display == 'on') 
    
    figure
    set(gcf, 'Name', 'Salt and papper noise removed');
    imshow(impluse_noise_removed);
    
    figure
    set(gcf, 'Name', 'Negative image');
    imshow(negative);
    
    figure
    set(gcf, 'Name', 'Sharpened');
    imshow(negative_filtered);
    
    figure
    set(gcf, 'Name', 'Contrast enhancement');
    imshow(im2uint8(contrast_enhanced));
    
end

end

