function [ fixed ] = fixVector( vector , numSamples)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    y = numSamples - size(vector,1);
    x = repmat(vector(end, :),y, 1);
    fixed = [vector; x];
    
    if  fixed(2, 2) == 0
        fixed(2, 2) = fixed(3, 2);
    end;
    fixed(1, 2) = fixed(2, 2);

end

