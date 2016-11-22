obj=VideoReader('video.mp4');
myimg=imread('toInsert.jpg');
result=read(obj,1);
interest=InterestRegion(result);
moy=moyenne(interest);
cov=Covariance(moy,interest);
seuil=500;
videoFinale=VideoWriter( 'videoFinale.avi');
open(videoFinale);

%Première image
distancemaha=DistanceMaha(result,moy,cov);
binary=seuillage(distancemaha,seuil);
binary=postTraitement(binary);
MatBary=barycentre(binary);
imagesc(binary);
%Produit Vectoriel?
MatBary=MatBary(:,[1 2 4 3]);


old=MatBary;
newFrame=motif2frame(result,result,MatBary(1,:),MatBary(2,:),1/1.20,zeros(520,576));
writeVideo(videoFinale,newFrame);
j=2;

for i=2:obj.NumberOfFrames
    result=getFrame(i,obj);
    distancemaha=DistanceMaha(result,moy,cov);
    binary=seuillage(distancemaha,seuil);
    binary=postTraitement(binary);
    
    MatBary=barycentre(binary);
    BarycentresActuels=TestProche(old,MatBary);
    newFrame=motif2frame(result,result,BarycentresActuels(1,:),BarycentresActuels(2,:),1/1.20,zeros(520,576));
    writeVideo(videoFinale,newFrame);
    old=BarycentresActuels;
    j=j+1
end
close(videoFinale);
