function huffman_encoded = encode_huffman( input_matrix )
%ENCODE_HUFFMAN compresses input matrix using Huffman's coding
% input_matrix is input matrix which can be expressed as int16

% Size of input for further processing
[M, N, ~] = (size(input_matrix));

% Casting input to int16
input_matrix = int16(input_matrix);

% Get unique symbols from input
symbols = unique(input_matrix(:));

% Calculating probabilities of symbols
probabilities = histc(input_matrix(:),symbols)./numel(input_matrix);

% Creating needed histroam_struct for genererate_huffman function
histogram_struct = struct('symbols', symbols, 'probabilities', probabilities);

%%%%%%%%%%%%%%%%%
huffman_table = generate_huffman_code(histogram_struct);

map = cell(length(huffman_table),1);

symbols = zeros(1, length(map));

% Loop thourgh array of structures and extract codes and symbols
for i=1: length(map)
    
    % Extracting binary codes from current structure
    map{i} = dec_to_binary_array(huffman_table(i).word, huffman_table(i).length);
    % Extracting symbols from current structure
    symbols(i) = huffman_table(i).symbol;
end
 
output_string = '';

% Looping thourgh all elements of input matrix and assigning their code to
% output
for i=1:M*N
    
    % Find code for current symbols
    temp = find(input_matrix(i)==symbols);
    
    % Add to output string
    output_string = strcat(output_string,char(map{temp}));
end

% Convert binary represenation to array of integeres
output_decimal = binary_to_dec(output_string, 8);

% Generate output structure
huffman_encoded = struct('size_M', M, 'size_N', N,'huffmans_table', huffman_table,'compressed', output_decimal);


end

