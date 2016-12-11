function [ binary ] = binarisationMain( image,moy,cov )
%Binarse la main
%   Detailed explanation goes here
%Définition du seuil et distance de maha avec celui ci 
seuil=200;
distancemaha=DistanceMaha(image,moy,cov);
binary=seuillage(distancemaha,seuil);

end

