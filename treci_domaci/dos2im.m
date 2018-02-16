function output_image = dos2im( input_file_name )
%DOS2IM decompress input image using dos2im decompression algorithm
%
%   A = DOS2IM(B) decompres compressed input image B and stores result to 
%   A
%
%Example
%-------
%
%   output = dos2im('lena_compressed');
%

% Matrix later needed to rearange indices
load zig_zag_index

% Matrix needed for quantization
load Q

% Input file name
filename = strcat(input_file_name,'.oe2dos');

% File handle
filehandle = fopen(filename);

% Dimensins header 
header = fread(filehandle, 3, 'int16');

% Dimensions of original image
M = header(1);
N = header(2);

% New dimensions of image
M_padded = 8 * ceil(M/8);
N_padded = 8 * ceil(N/8);

% Number of 8x8 blocks in padded image
num_of_8x8 = M_padded*N_padded/64;

% Number of symbols in Huffmans table
num_of_symbols = header(3);


% Reading whole huffman table

iterator = 1;

while(iterator <= num_of_symbols)
    
    % Reading first 2 bytes
    temp = fread(filehandle, 2, 'int16');
    
    % Assigning read 2 bytes
    huffmans_table(iterator).symbol = temp(1);
    huffmans_table(iterator).length = temp(2);
    
    % Calculating how many bytes are read for current symbols
    bytes_count = ceil(huffmans_table(iterator).length/8);
    
    %Prealocating for speed
    huffmans_table(iterator).word = zeros(1,bytes_count);
    
    % Reading all codes for the current symbol
    for byte = 1: bytes_count
        huffmans_table(iterator).word(byte) = fread(filehandle, 1, 'int16');
    end
    
    % Incrementing iterator
    iterator = iterator + 1;
end

% Reading encoded data, 
compressed = fread(filehandle, 'uint8')';

% Creating needed structure for decode_huffman
huffman_encoded = struct('size_M', M, 'size_N', N,'huffmans_table', huffmans_table,'compressed', compressed);

% Decoding encoded data
[huffman_decoded, eob] = decode_huffman_EOB(huffman_encoded);


% Creating inverse zig_zag_index matrix
inv_zig_zag_index = zig_zag_index;
for k = 1:64
    inv_zig_zag_index(k) = find(zig_zag_index == k);
end

decoded_zig_zag = zeros(64, num_of_8x8);

% Zig zagging the decoded matrix
k = 1;
for j = 1 : num_of_8x8
    for i = 1 : 65
        if huffman_decoded(k) == eob
            k = k + 1; break;
        else
            decoded_zig_zag(i, j) = huffman_decoded(k);
            k = k + 1;
        end
    end
end
dec_after_zig_zag = decoded_zig_zag(inv_zig_zag_index, :);

% Reshape current result for future calculations
predict_codded = col2im(dec_after_zig_zag, [8 8], [M_padded N_padded],'distinct');

% Predictive decoding DC coeffs 
predict_decodded = predict_decode(predict_codded);

% Dequantisation with given matrix
dct = blockproc(predict_decodded, [8 8], @(block)block.data.*Q);
% dct =predict_decodded;

% Inverse DCT
R = dctmtx(8);
inv_dct = blockproc(dct, [8 8], @(block)R'*block.data*R);

% Converting valuse to uint8
output_image = uint8(inv_dct(1:M,1:N));


fclose(filehandle);

end

