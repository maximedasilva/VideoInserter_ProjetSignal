
obj=VideoReader('video.mp4');
result=getFrame(40,obj);
figure, imshow(result);
interest=InterestRegion(result);
figure, imshow(interest)
moy=moyenne(interest);
cov=Covariance(moy,interest);
distancemaha=DistanceMaha(result,moy,cov);
seuil=330;
binary=seuillage(distancemaha,seuil);
binary=postTraitement(binary);
MatBary=barycentre(binary);
test=0;



    