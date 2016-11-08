result=getFrame(40);
figure, imshow(result);
interest=InterestRegion(result);
figure, imshow(interest)
moy=moyenne(interest);
cov=Covariance(moy,interest);
distancemaha=DistanceMaha(result,moy,cov);