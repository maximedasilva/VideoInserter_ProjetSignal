function [ moy,cov ] = InitMain( image )
%Récupération du modèle de picot pour la main 
interest=image(123:147,283:290,:);%récupération de la zone d'intérêt de la main
moy=moyenne(interest);
cov=Covariance(moy,interest);
end

