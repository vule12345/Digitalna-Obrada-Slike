function  [output_matrix, EOB_idx] = decode_huffman_EOB( huffman_encoded)
%DECODE_HUFFMAN_EOB decompress compressed matrix. 
% Difference between this and normal huffman decode is that this functions
% uses EOB as stop condition

% Get size from input structure
M =  huffman_encoded.size_M;
N =  huffman_encoded.size_N;

% Get huffman table
huffman_table = huffman_encoded.huffmans_table;

% Get compressed matrix
compressed = huffman_encoded.compressed;

% Create map 
map = cell(length(huffman_table),1);

symbols = zeros(1, length(map));

for i=1: length(map)
    map{i} = dec_to_binary_array(huffman_table(i).word, huffman_table(i).length);
    symbols(i) = huffman_table(i).symbol;
end


% New dimensions of image
M_padded = 8 * ceil(M/8);
N_padded = 8 * ceil(N/8);

% Number of EOBs in image
num_of_EOBS = M_padded*N_padded/64;

% EOB value
EOB = max(symbols(:));
EOB_idx = EOB;

% Create hash map from huffmans table
huffman_map = containers.Map(map, symbols);

result = [];

% Create array of ones and zeroes representing compressed data
codded_seq = '';
for j=1: length(compressed)
    codded_seq = strcat(codded_seq, dec_to_binary(compressed(j),8));
end

i=1;
EOB_counter = 0;

% Looping thorugh compressed binary data
while(i<=length(codded_seq) && EOB_counter < num_of_EOBS)
    
    % Take one bit
    codded_string = '';
    codded_string = strcat(codded_string, codded_seq(i));
    
    % If codded_string is not in hash table add another bit until it is
    while(huffman_map.isKey(codded_string) == 0)
        i=i+1;
        codded_string = strcat(codded_string, char(codded_seq(i)));
    end
    
    % If decoded symbol is EOB increaces counter, which is needed for loop
    % condition
    if(huffman_map(codded_string)==EOB)
        EOB_counter = EOB_counter + 1;
    end
    
    % Add current decoded symbol
    result = [result huffman_map(codded_string)];
 
    i=i+1;
    
    
end
output_matrix = result;
end 

