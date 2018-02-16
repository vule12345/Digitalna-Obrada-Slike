function output = predict_decode( input_matrix )
%PREDICT_DECODING decodes DC coefficiensts of every 8x8 block of input matrix

% Getting size of input matrix
[M, N] = size(input_matrix);

% Copying input to output matrix
output = input_matrix;

%Looping thorugh DC coefficients of every 8x8 block
for i = 1:M/8   
    
    % Row of current DC coeff to be decodded
    i_current = (i - 1)*8 + 1;
    
    % Row of previous coeff used for decodding
    i_past = (i - 2)*8 + 1;
    
    for j = 1:N/8
       
        % Column of current DC coeff to be decodded
        j_current = (j-1)*8 + 1;
        
        % Column of previous coeff used for decodding
        j_past = (j-2)*8 + 1;
        
        % If current block is first in row use first coeff from previuous
        % block
        if(j==1)
            % Skipping first coeff(globally first) with this if
            if(i>1)
                output(i_current,1) = input_matrix(i_current,1) + output(i_past,1);
            end
        % If none of past conditions are met just predict 
        else
            output(i_current,j_current) = input_matrix(i_current,j_current) + output(i_current,j_past);
        end
    end
end



end

