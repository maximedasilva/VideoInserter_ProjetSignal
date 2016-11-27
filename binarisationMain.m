function [ binary ] = binarisationMain( image,moy,cov )
%BINARISATIONMAIN Summary of this function goes here
%   Detailed explanation goes here
seuil=200;
distancemaha=DistanceMaha(image,moy,cov);
binary=seuillage(distancemaha,seuil);
%binary=postTraitement(binary)
imagesc(binary);

end

