function [ matCov ] = Covariance(moy,reg )
%Donne la covariance d'une matrice de valeur
%   Detailed explanation goes here
%Affectation de la matrice de covariance
matCov=zeros(3:3);
%Pour chaque couleur
for c=1:3
    for c2=1:3%On regarde les 3 couleurs
        test=mean(reg(:,:,c));
        matCov(c,c2)=mean(mean((reg(:,:,c)-moy(c)).*(reg(:,:,c2)-moy(c2))))
        moy(c)
    end
end

end

