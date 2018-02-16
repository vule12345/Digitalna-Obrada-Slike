function binary_string = dec_to_binary_array( word, len )
% Function which usses dec_to_binary on array
binary_string = '';

for i=1 : length(word)
    
    if(len>= 8 && word(i) ~=0)
        binary_number = dec_to_binary(word(i),8);
        len = len-8;
        binary_string = strcat(binary_string, binary_number);
    else
       binary_number = dec_to_binary(word(i),len);
       binary_string = strcat(binary_string, binary_number); 
       break;  
    end
    
    
end


end

