function [ moy,N ] = moyenne( reg )
%MOYENNE Summary of this function goes here
%   Detailed explanation goes here
moy=zeros(3,1);
N=0;

        for c=1:3
            moy(c)=mean(mean(reg(:,:,c)));
        end
end

