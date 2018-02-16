function output_image = dos_mfnr_gray_1( collection, K, h)
%DOS_MFNR_GRAY Reduce noise from first image of frame collection using
%information from all frames. Function works with gray level images stored
%in 2D matrix collection and filters them using KxK neighborhood with
%strengh of filtering of h

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


% Polu sirina prozora za usrednjavanje
half_k = floor(K/2);

% Prosirenje slike
temp1 = padarray(collection,[half_k, half_k],'symmetric', 'both');

padded_img = mat2gray(temp1);

for i= half_k+1 :half_k+M
    for j=half_k+1 : half_k+N
        
        % Racunanje slicnosti izmedju KxK okoline istog piksela
        euclide = (padded_img(i-half_k:i+half_k,j-half_k:+j+half_k, 1) - padded_img(i-half_k:i+half_k,j-half_k:+j+half_k, 1:9) ).^2;
        distanca = sum(sum(euclide))/(K*K);
        
        % Racunanje tezinsikih funkcija
        numerator = max(distanca, 0);
        weight =  double(exp(-numerator/(h^2)));
        
        % Variable used for normalizing weight functions
        Z = sum(sum(weight));
       
        output_image(i,j)=(1/Z)*sum(padded_img(i,j,:) .* weight);
        
    end
end




end

