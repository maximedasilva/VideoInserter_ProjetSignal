function [image ] = getFrame( i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
obj=VideoReader('video.mp4');
image=obj.read(i);
end

