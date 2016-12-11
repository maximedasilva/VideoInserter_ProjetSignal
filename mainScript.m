%Chargement des vidéos
obj=VideoReader('video.avi');
myVideo=VideoReader('InsideIn.avi');
myImg=read(myVideo,1);
result=read(obj,1);

%Modèle de picot
interest=InterestRegion(result);
moy=moyenne(interest);
cov=Covariance(moy,interest);

%Initialisation du videoWriter
videoFinale=VideoWriter('output.avi');
open(videoFinale);

%Modèle de picot pour la main
main=read(obj,50);
[moyMain,CovMain]=InitMain(main);

%Première image
distancemaha=DistanceMaha(result,moy,cov);
seuil=500;
binary=seuillage(distancemaha,seuil);
binary=postTraitement(binary);
MatBary=barycentre(binary);
image(binary);
colormap(gray);

%Ordonnancement des points bleu
MatBary=MatBary(:,[1 2 4 3]);


%Récupération de la matrice binaire de la main
 MainBinaire=binarisationMain(result,moyMain,CovMain);
 
 %création de l'image et insertion dan la vidéo
 newFrame=motif2frame(myImg,result,MatBary(1,:),MatBary(2,:),1/1.20,MainBinaire);
 writeVideo(videoFinale,newFrame);
 
 %Affectation de la matrice pour le testProche
  old=MatBary;
  j=0
  %Pour chaque image
 for i=2:obj.NumberOfFrames
     %Décallage temporel
    if(i<20)
        myImg=read(myVideo,1);
    else
        myImg=read(myVideo,i-19);
    end
    %Récupération de l'image i et distance maha pour la main et les points
    %bleus
    result=read(obj,i);
    distancemaha=DistanceMaha(result,moy,cov);
    binary=seuillage(distancemaha,seuil);
    j=j+1
    binary=postTraitement(binary);
    MainBinaire=binarisationMain(result,moyMain,CovMain);
    %Barycentres
    MatBary=barycentre(binary);
    %Ordonnancement
    BarycentresActuels=TestProche(old,MatBary);
    
    %Affectation de la nouvelle et écriture
    newFrame=motif2frame(myImg,result,BarycentresActuels(1,:),BarycentresActuels(2,:),1/1.20,MainBinaire);
    writeVideo(videoFinale,newFrame);
    %Affectation des barycentres actuels
    old=BarycentresActuels;
 end

%Fermeture du stream
close(videoFinale);
