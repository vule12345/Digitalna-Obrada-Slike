function binary = dec_to_binary( number, num_of_bits )
%DEC_TO_BINARY Converts  input number to string represention of it
%and stores it as string. Number will have num_of_bits bits

% Convert number to binary
binary_converted = dec2bin(number);

% Calculate expansion
extend = 8 - length(binary_converted);

% Prefix zeros
extend_zeroes(1:extend) = '0';

% Adding leading zeros
binary_long = strcat(extend_zeroes, binary_converted);

% Converting to specifed binary format
if(number ~= 0)
    binary = binary_long(1:num_of_bits);
else
    binary(1:num_of_bits) = '0';
end

end

