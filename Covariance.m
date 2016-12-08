function [ matCov ] = Covariance(moy,reg )
%COVARIENCE Summary of this function goes here
%   Detailed explanation goes here
matCov=zeros(3:3);
for c=1:3
    for c2=1:3
        test=mean(reg(:,:,c));
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

end

