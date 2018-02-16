function output_image = dos_mfnr_gray_2( collection , s )
%DOS_MFNR_GRAY Reduce noise from first image of frame collection using
%information from all frames. Function works with gray level images stored
%in 2D matrix collection and filters them using strengh of s.


% Racunanje dimenzije slika i kolekcije
[M,N, L] =  size(collection);

[optim, metric]= imregconfig('monomodal');
for i=2 :L
    collection(:,:,i) = imregister(collection(:,:,i), collection(:,:,1), 'affine',optim, metric);
end

% Alokacija promenljive za racunanje varijasni piksela
% varijanse = zeros(M, N);

% Alokacija promenljive za racunanje izlazne slike
output_image = zeros(M, N);
 
% Petlja kroz celu sliku
for i=1: M
    for j=1 : N
        
        piksel = collection(i,j,:);
        suma=0;
        all = 0;
        
        % Petlja za odbacivanje piksela koji nije odgovarujeceg
        for l=1 : 9
           if(piksel(l) < (1+s)*collection(i,j,1) && piksel(l) > (1-s)*collection(i,j,1))
               
              suma = suma +piksel(l);
              all =all +1;
               
           end
        
            output_image(i,j) = suma/all;
        end
        
            output_image(i,j) = suma/all;

    end
end




end

