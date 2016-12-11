function [ matBary ] = barycentre( img )
%récupère une image et retourne la position des barycentres
%   Detailed explanation goes here
    %Labellisation et affectation de la nouvelle matrice
    img=bwlabel(img);
    matBary=zeros(2,4);
    %Pour les 4 points, affectation des barycentres
   for i=1:4
    [y, x] = find(img == i);
    matBary(1,i) = mean(double(x));
    matBary(2,i) = mean(double(y));
   end
end

