function [ fixed ] = fixVector( vector , numSamples)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    y = numSamples - size(vector,1);
    x = repmat(vector(end, :),y, 1);
    fixed = [vector; x];

end

