function [ MLE, errBar ] = processMLE( input, evalNum )
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
meanError = mean(error, 2);
errorLog = log10(abs(error));

MLE = mean(errorLog, 2);
errBar = std(errorLog,0, 2);

end

