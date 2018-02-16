function  output_matrix = decode_huffman( huffman_encoded )
%DECODE_HUFFMAN decompress compressed matrix stored in huffman_encoded
%structure

% Get size from input structure
M =  huffman_encoded.size_M;
N =  huffman_encoded.size_N;

% Get huffman table
huffman_table = huffman_encoded.huffmans_table;

% Get compressed matrix
compressed = huffman_encoded.compressed;

% Create map 
map = cell(length(huffman_table),1);

% for i=1: length(huffman_table.word)
%     map{i} = dec_to_binary_array(huffman_table.word(i), huffman_table.length(i));
% end

symbols = zeros(1, length(map));

for i=1: length(map)
    map{i} = dec_to_binary_array(huffman_table(i).word, huffman_table(i).length);
    symbols(i) = huffman_table(i).symbol;
end

% Create hash map from huffmans table
huffman_map = containers.Map(map, symbols);

result = [];

% Create array of ones and zeroes representing compressed data
codded_seq = '';
for j=1: length(compressed)
    codded_seq = strcat(codded_seq, dec_to_binary(compressed(j),8));
end

% codded_seq = dec_to_binary_array(compressed, length(compressed)*8);

i=1;
len_of_decoded = 0;

% Looping thorugh compressed binary data
while(i<=length(codded_seq) && len_of_decoded < M*N)
    
    % Take one bit
    codded_string = '';
    codded_string = strcat(codded_string, codded_seq(i));
    
    % If codded_string is not in hash table add another bit until it is
    while(huffman_map.isKey(codded_string) == 0)
        i=i+1;
        codded_string = strcat(codded_string, char(codded_seq(i)));
    end
   
    % Add current decoded symbol
    result = [result huffman_map(codded_string)];
    
    % Increase number of decoded,which is needed for loop condtion
    len_of_decoded =len_of_decoded +1;
    i=i+1;
   
    
end

% Reshape array to matrix MxN
output_matrix = reshape(result, [M, N]);
end 
