function [ Im ] = postTraitement( binary )
%Postraitement, qui fait une dilatation et une érosion sur une image
%donnée.
%   Detailed explanation goes here
se=strel('disk',5);%Sélection de la forme 
Im= imerode(binary, se);%Erosion 
Im=imdilate(Im,se);%Dilatation
Im=Im.*255;
end

