obj=VideoReader('video.avi');
result=getFrame(01,obj);
figure, imshow(result);
interest=InterestRegion(result);
figure, imshow(interest)
moy=moyenne(interest);
cov=Covariance(moy,interest);
seuil=330;
videoFinale=VideoWriter( 'videoFinale.avi', 'Indexed AVI' );
videoFinale.Colormap = gray(256);
open(videoFinale);

%Premi�re image
distancemaha=DistanceMaha(result,moy,cov);
binary=seuillage(distancemaha,seuil);
binary=postTraitement(binary);
MatBary=barycentre(binary);
old=MatBary;
writeVideo(videoFinale,binary);
for i=2:obj.NumberOfFrames
    result=getFrame(i,obj);
    distancemaha=DistanceMaha(result,moy,cov);
    seuil=330;
    binary=seuillage(distancemaha,seuil);
    binary=postTraitement(binary);
    writeVideo(videoFinale,binary);
    MatBary=barycentre(binary);
    BarycentresActuels=TestProche(old,MatBary);
    old=BarycentresActuels;
end
close(videoFinale);
