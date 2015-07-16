function [ ME, errBar ] = processME( input, evalNum )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
numRemove = 10;

for i=1:numRemove
    [worse, worsePos] = max(input,[], 2);
    input(:, worsePos(end)) = []  ;
    
    [best, bestPos] = min(input,[], 2);
    input(:, bestPos(end)) = []  ;
end


error = input;
ME = mean(error, 2);
errBar = std(error,0, 2);
errBar = 0.434*errBar./ME;
ME = log10(abs(ME));
% errBar = log10(abs(errBar));


h =errorbar(evalNum, ME, errBar, 'b');
s = h.LineStyle;
h.MarkerFaceColor = 'r';
h.LineStyle = ':';
h.Color = 'r';


end

