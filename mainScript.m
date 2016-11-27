obj=VideoReader('video.avi');
myVideo=VideoReader('InsideIn.avi');
myImg=read(myVideo,1);
result=read(obj,1);
interest=InterestRegion(result);
moy=moyenne(interest);
cov=Covariance(moy,interest);
seuil=500;
videoFinale=VideoWriter('output.avi');
open(videoFinale);
main=read(obj,50);
[moyMain,CovMain]=InitMain(main);
%Première image
distancemaha=DistanceMaha(result,moy,cov);
binary=seuillage(distancemaha,seuil);
binary=postTraitement(binary);
MatBary=barycentre(binary);
imagesc(binary);
%Produit Vectoriel?
%MatBary=MatBary(:,[2 4 3 1]);
MatBary=MatBary(:,[1 2 4 3]);
old=MatBary;
MainBinaire=binarisationMain(result,moyMain,CovMain);
newFrame=motif2frame(myImg,result,MatBary(1,:),MatBary(2,:),1/1.20,MainBinaire);
writeVideo(videoFinale,newFrame);
j=2;

for i=2:obj.NumberOfFrames
    if(i<20)
        myImg=read(myVideo,1);
    else
        myImg=read(myVideo,i-19);
    end
    result=getFrame(i,obj);
    distancemaha=DistanceMaha(result,moy,cov);
    binary=seuillage(distancemaha,seuil);
    binary=postTraitement(binary);
    MainBinaire=binarisationMain(result,moyMain,CovMain);
    MatBary=barycentre(binary);
    BarycentresActuels=TestProche(old,MatBary);
    newFrame=motif2frame(myImg,result,BarycentresActuels(1,:),BarycentresActuels(2,:),1/1.20,MainBinaire);
    writeVideo(videoFinale,newFrame);
    old=BarycentresActuels;
    j=j+1
end
close(videoFinale);
