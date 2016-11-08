function [ matCov ] = Covariance(moy,reg )
%COVARIENCE Summary of this function goes here
%   Detailed explanation goes here
matCov=zeros(3:3);
for c=1:3
    for c2=1:3
        test=mean(reg(:,:,c));
        %matCov(c,c2)=mean(mean(mean(((reg(:,:,c)))))-moy(c)* mean(mean(reg(:,:,c2)))-moy(c2));
        matCov(c,c2)=mean(mean((reg(:,:,c)-moy(c)).*(reg(:,:,c2)-moy(c2))))
        moy(c)
    end
end









R1=reg(:,:,1);
R2=R1(:);
G1=reg(:,:,2);
G2=G1(:);
B1=reg(:,:,3);
B2=B1(:);
%Calcul de la covariance 
%sigma11=(sum((R2-moy(1)).*(R2-moy(1))))/N;
%sigma12=(sum((R2-moy(1)).*(G2-moy(2))))/N;
%sigma13=(sum((R2-moy(1)).*(B2-moy(3))))/N;
%sigma21=sigma12;
%sigma22=(sum((G2-moy(2)).*(G2-moy(2))))/N;
%sigma23=(sum((G2-moy(2)).*(B2-moy(3))))/N;
%sigma31=sigma13;
%sigma32=sigma23;
%sigma33=(sum((B2-moy(3)).*(B2-moy(3))))/N;

% On crée la matrice des covariances
%[sigma11 sigma12 sigma13;sigma21 sigma22 sigma23;sigma31 sigma32 sigma33];

end

