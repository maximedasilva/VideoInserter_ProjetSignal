function [ordonneActuel ] = TestProche(old, actual )
%TESTPROCHE Summary of this function goes here
%   Detailed explanation goes here

ordonneActuel=zeros(2,4)
for i=1:4
    minimum=realmax;
    for j=1:4
    distance=(old(1,j)-actual(1,i))^2+(old(2,j)-actual(2,i))^2;
        if(distance<minimum)
            minimum=distance;
            ordonneActuel(:,i)=actual(:,j);
        end
    end

end
end

