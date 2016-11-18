function [ Im ] = postTraitement( binary )
%POSTTRAITEMENT Summary of this function goes here
%   Detailed explanation goes here
se=strel('disk',5);
Im= imerode(binary, se);
Im=imdilate(Im,se);
Im=Im.*255;
end

