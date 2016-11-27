function [ moy,cov ] = InitMain( image )
%INITMAIN Summary of this function goes here
interest=image(123:147,283:290,:);
%interest=image(min(y):max(y),min(x):max(x),:);
moy=moyenne(interest);
cov=Covariance(moy,interest);
end

