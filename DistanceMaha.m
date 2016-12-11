function [DistMaha] = DistanceMaha( img,moy,matCov )
%Fonction Distance de mahalanobis qui per permet avec d'avoir la distance
%de mahanobis en tout point d'une image avec une moyenne et une covariance
%   Detailed explanation goes here

invCov=inv(matCov);%On prend l'inverse
imgR=double(img(:,:,1));%On affecte les 3 composantes
imgV=double(img(:,:,2));
imgB=double(img(:,:,3));

%creation de la matrice des xi- moyenne , avec tous les pixels d'un coup
lineR=reshape(imgR,1,numel(imgR));
lineV=reshape(imgV,1,numel(imgV));
lineB=reshape(imgB,1,numel(imgB));
lineR=lineR-moy(1);
lineV=lineV-moy(2);
lineB=lineB-moy(3);
Vectmaha=[lineR;lineV;lineB];


W= invCov * Vectmaha;
DistMaha= Vectmaha .* W;

DistMaha = sum(DistMaha,1);

%On recrée l'image avec les distances
DistMaha= reshape( DistMaha, [size(img,1),size(img,2)]);
end

