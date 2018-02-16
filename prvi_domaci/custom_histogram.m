function result = custom_histogram(img, depth)
%custom_histogram Calculate histogram of input image.
%   Function takes 2 arguments. First argument img is integer type image
%   with values in range [0,1]. Second arugment depth represents range of
%   bins in histogram(value in image).


% Allocating space for faster calculation
result = zeros(1,depth);

% Simple for loop which goes through all values possible in image
for bin=1:depth+1
    result(bin) = sum(img(:)== (bin-1));
end

end

