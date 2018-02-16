function CODE = makecode(sc, codeword, CODE)
% Code from Gonazels!!!
% Scan the nodes of a Huffman source reduction tree recursively to
% generate the indicated variable length code words.

if isa(sc, 'cell')                                % For cell array nodes,
   CODE = makecode(sc{1}, [codeword 0], CODE);    % add a 0 if the 1st element
   CODE = makecode(sc{2}, [codeword 1], CODE);    % or a 1 if the 2nd
else                                 % For leaf (numeric) nodes,
   CODE{sc} = char('0' + codeword);  % create a char code string
end
end
