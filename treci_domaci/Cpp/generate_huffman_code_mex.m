function huffman_table  = generate_huffman_code_mex( hist_struct )
%GEBERATE_HUFFMAN_CODE generates Huffman's code table based on input
%histogram of image using mex files
%Table is created only for values with probability bigger than 0

% Checking input parameters
if(nargin > 1)
    error('Function takes only 1 argument');
end
validateattributes(hist_struct.probabilities, {'double'}, {'>',0,'<=',1})

% Parsing input structure
probabilites = hist_struct.probabilities(hist_struct.probabilities>0);
symbols = hist_struct.symbols;

[symbols, words, code_length] = createHuffmanTable(symbols, probabilites);

huffman_table = struct('symbol', symbols,'length',code_length,'word',words);

end

