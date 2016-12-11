function [ordonneActuel ] = TestProche(old, actual )
%ordonnancement des barycentres
%   Detailed explanation goes here

ordonneActuel=zeros(2,4);%Cr�ation de la nouvelle matrice
for i=1:4%pour chaque barycentres de l'image pr�c�dente
    minimum=realmax;%On affecte le plus grand des r�els 
    for j=1:4%POur chaque point de la nouvelle matrice
    distance=(actual(1,j)-old(1,i))^2+(actual(2,j)-old(2,i))^2;
    %On fait la distance euclidienne entre les deux points
        if(distance<minimum)%Si le point est plus proche 
            minimum=distance;%on affecte le nouveau minimum
            ordonneActuel(:,i)=actual(:,j);%Et on affecte la matrice ordonn�e
        end
    end

end
end

