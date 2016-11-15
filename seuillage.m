function [ imBinaire ] = seuillage( distMaha, seuil )
%SEUILLAGE Summary of this function goes here
%   Detailed explanation goes here

imBinaire=distMaha;
for i=1:size(distMaha,1)
    for j=1:size(distMaha,2)
        if distMaha(i,j)<seuil
            imBinaire(i,j)=1;
        else imBinaire(i,j)=0;
        end
    end
end
end


