function [] = im2dos_quan(input_image, quality, output_file_name)
%IM2DOS compresses input_image with ,,dos,, compression algorithm but
%without quantization
%
%   B = IM2DOS(INPUT_IMAGE,QUALITY, OUTPUT_FILE_NAME) compresses input uint8
%   image with quality and stores the output to output_file_name.oe2dos 
%   
% Example
% -------
%
%   ~ = im2dos('lena.tif', 33, 'lena_compressed');
%
%--------




% Because 8x8 blocks for DCT are used quality parametar must be bettween
% 1 and 64
 if(quality <1 || quality > 64)
     error('Quality parametar must be from range of [1, 64]'); 
 end

filename = strcat(output_file_name,'.oe2dos');
 
% Matrix later needed to rearange indices
load zig_zag_index

% Matrix needed for quantization
load Q

% Getting dimensions of input image
[M_original, N_original, ~] = size(input_image);

% Casting to double
img = double(input_image);

% New dimensions of image
M_padded = 8 * ceil(M_original/8);
N_padded = 8 * ceil(N_original/8);

% Size of padding
padding_M = M_padded - M_original; 
padding_N = N_padded - N_original;

% Padding the image
padded_img = padarray(img, [padding_M padding_N],'symmetric','both');

% Creating DCT matrix
dct_block = dctmtx(8);

% Calculataing dct for every 8x8 in original image
dct_img = blockproc(padded_img, [8 8],  @(block) dct_block*block.data*(dct_block'));

% Removing 64-quality components of dct transormated image
dct_img_filtered = zeros(M_padded, N_padded);

row_block_num = M_padded / 8;
column_block_num = N_padded / 8;
reject = 64 - quality;

% Calling remove_coeffs for every 8x8 block in dct transformation. 
% remove_coeffs removes reject number of smallest values in input matrix.
            % for i=1: row_block_num
            %     for j=1: column_block_num
            %       dct_img_filtered(((i-1)*8+1):i*8,((j-1)*8+1):j*8) = remove_coeffs(dct_img(((i-1)*8+1):i*8,((j-1)*8+1):j*8), reject);
            %     end
            % end

dct_img_filtered = blockproc(dct_img,[8 8],@(block) remove_coeffs(block.data, reject));


% Using quantization matrix Q, filtered dct transformed image is uniformaly
% quantized
% dct_img_quantized = blockproc(dct_img_filtered,[8 8],@(block) round(block.data./Q));
dct_img_quantized = round(dct_img_filtered);

% Predictive coding of DC coeffs
dct_img_predicted = predict_coding(dct_img_quantized);

% Transforming matrix to columns
dct_img_col = im2col(dct_img_predicted, [8 8], 'distinct');

% Number of blocks(columns)
num_of_blocks = size(dct_img_col, 2);

% Transforming to zig_zag order
dct_zig_zag = dct_img_col(zig_zag_index, :);

% Calculating EOB
EOB = max(dct_zig_zag(:)) + 1;

% Alocating result array
result = zeros(numel(dct_img_col)+size(dct_img_col,2),1);

% Initial value for count
count = 0;

% Looping through all blocks and collecting pixels
for j = 1:num_of_blocks
    
    % Collecting elemeents from current block
    i = find(dct_zig_zag(:, j), 1, 'last');
    
    % If block is empty assign zero
    if isempty(i)
        i = 0;
    end
    
    % Getting indices for writing in collective array
    p = count + 1;
    q = p + i;
    
    % Writing elemetns into matrix
    result(p:q) = [dct_zig_zag(1:i, j); EOB];
    
    % Incrementing counter
    count = count + i + 1;
end

% Cropping the result
result((count+1):end) = [];

% Huffman encoding result
huffman_encoded = encode_huffman((result'));

% Extracting huffman table
table = huffman_encoded.huffmans_table;

% Opening file
file_handle= fopen(filename,'w');

% Writing to binary file

% Writing headers
fwrite(file_handle, M_original, 'int16');
fwrite(file_handle, N_original, 'int16');
fwrite(file_handle, length(table), 'int16');

for i=1:length(table)
    fwrite(file_handle, table(i).symbol, 'int16');
    fwrite(file_handle, table(i).length, 'int16');
    fwrite(file_handle, table(i).word, 'int16');
end

% Writing compressed files
fwrite(file_handle, uint8(huffman_encoded.compressed),'uint8');

% Closing the file
fclose(file_handle);

end

