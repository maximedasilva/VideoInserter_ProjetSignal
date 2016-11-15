function [DistMaha] = DistanceMaha( img,moy,matCov )
%DISTANCEMAHA Summary of this function goes here
%   Detailed explanation goes here

invCov=inv(matCov);
imgR=double(img(:,:,1));
imgV=double(img(:,:,2));
imgB=double(img(:,:,3));

%creation de la matrice des xi- moyenne , avec tous les pixels d'un coup
TransImgR=imgR';
TransImgV=imgV';
TransImgB=imgB';
lineR=reshape(TransImgR,1,numel(TransImgR));
lineV=reshape(TransImgV,1,numel(TransImgV));
lineB=reshape(TransImgB,1,numel(TransImgB));
lineR=lineR-moy(1);
lineV=lineV-moy(2);
lineB=lineB-moy(3);
Vectmaha=[lineR;lineV;lineB];


W= invCov * Vectmaha;
DistMaha= Vectmaha .* W;

end

