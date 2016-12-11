function [ moy] = moyenne( reg )
%Calcul
moy=zeros(3,1);%Création de la matrice

        for c=1:3
            moy(c)=mean(mean(reg(:,:,c)));%Calcul de la moyenne 
            %pour chaque couleur de la zone d'intérêt
        end
end

