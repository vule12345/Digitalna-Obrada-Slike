function decimal = binary_to_dec( number, num_of_bits )
%BINARY_TO_DEC Converts input binary number to decimal using num_of_bits
%bits

% Get length of input number
len = length(number);

% Calculate needed number of bits for expansion
to_whole = num_of_bits - mod(len, num_of_bits);

% If result is num_of_bits there is not expansion
if(to_whole == num_of_bits)
    to_whole = 0;
end

% Trailing zeros
temp(1:to_whole) = '0';

% Adding trailing zeros
number = [number temp];

decimal = [];

% Looping thourght input number
for i=1:num_of_bits:length(number)

    % Conver to decimal
    decimal_num = bin2dec(number(i:i+num_of_bits-1));   
    
    % Add element to array
    decimal=[decimal decimal_num];
    
end


end

