function [ matBary ] = barycentre( img )
%BARYCENTRE Summary of this function goes here
%   Detailed explanation goes here
    img=bwlabel(img);
    matBary=zeros(2,4)
   for i=1:4
    [x,y] = find(img == i);
    matBary(1,i) = mean(double(x));
    matBary(2,i) = mean(double(y));
end

end

