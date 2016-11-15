function [image ] = getFrame( i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
obj=VideoReader('video.avi');
image=obj.READFRAME(i);
end

