function [ imBinaire ] = seuillage( distMaha,seuil )
%Récupération de l'image bianire avec le sueuillage
%   Detailed explanation goes here

imBinaire=distMaha;%Récupération de la matrice de distance
for i=1:size(distMaha,1)%Pour chaque ligne
    for j=1:size(distMaha,2)%Et chaque colonnes
        if distMaha(i,j)<seuil%Si la distance est plus petite que le seuil
            imBinaire(i,j)=1;%Alors l'image bianire=1
        else imBinaire(i,j)%Sinon =0
        end
    end
end
end


