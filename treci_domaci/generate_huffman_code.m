function huffman_table  = generate_huffman_code( hist_struct )
%GEBERATE_HUFFMAN_CODE generates Huffman's code table based on input
%histogram of image
%Table is created only for values with probability bigger than 0

% Checking input parameters
if(nargin > 1)
    error('Function takes only 1 argument');
end
validateattributes(hist_struct.probabilities, {'double'}, {'>',0,'<=',1})
%validateattributes(hist_struct.symbols, {'int16'})

% Parsing input structure
probabilites = hist_struct.probabilities(hist_struct.probabilities>0);
symbols = hist_struct.symbols;

codes = cell(length(probabilites), 1);

% Checking for trivial case when there is only 1 element in input array
if length(probabilites) > 1
    probabilites = probabilites / sum(probabilites);
    
    %Creating Huffman's code tree with function reduce
    tree = reduce(probabilites);
    
    % Traversing the tree to get the codes
    codes = makecode(tree, [], codes);
else
    % Trival case
    codes = {'1'};
end

% Creagin array of structs for output
for j=1:length(codes)
    
    % Creating array of integer numbers representing binary codes
    word = binary_to_dec(cell2mat(codes(j)), 8);
    
    % Saving length of binary codes
    len = length(cell2mat(codes(j)));
    
    % Creating jth element of struct
    huffman_table(j) = struct('symbol', symbols(j),'length', len, 'word', word);
end

end

