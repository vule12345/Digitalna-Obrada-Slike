function output_matrix = remove_coeffs(input_matrix, num_of_coeff)
%REMOVE_COEFFS removes num_of_coeff smallest values from input_matrix
%   Removes means it sets them to zero

input = abs(input_matrix);

% Sort matrix
[~, idx] = sort(input(:));

% Copy input matrix to oupput
output_matrix = input_matrix;

% Take first n numbers from copied matrix and set them to 0
output_matrix(idx(1:num_of_coeff)) = 0;

end

