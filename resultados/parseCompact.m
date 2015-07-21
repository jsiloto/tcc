function [ best, bestError, bestPop, bestPopError, bestParam ] = parseCompact( numEval, recordInterval, numRuns, filename )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

evalNum = recordInterval:recordInterval:numEval;
completeParams = [];
completeResult = [];
completeError = [];
completePopResult = [];
completePopError = [];

finalResult = [];
fid = fopen(filename);
baseline = fgetl(fid);
baseline = strread(baseline);
% baseline = 0.0133697;

while 1
    [ bestMean, bestStdev, popMean, popStdev, paramName, paramsstr, fEnd] = parseOneParameter(  fid, numEval, recordInterval, numRuns);
    
    if(fEnd)
        break;
    end
    
    bestMean = bestMean/baseline;
    bestStdev = bestStdev/baseline;
    popMean = popMean/baseline;
    popStdev = popStdev/baseline;
    
    completeParams = strvcat(completeParams, paramsstr);
    %Get Best result statistics
    completeResult = [ completeResult bestMean];
    completeError = [ completeError bestStdev];
    finalResult = [ finalResult; [bestMean(end) bestStdev(end)]];
    
    %Get Population average statistics
    completePopResult = [ completePopResult popMean];
    completePopError = [ completePopError popStdev];
    
end

[best bestPos] = min(finalResult(:, 1));

best = 100* completeResult(:, bestPos);
bestError = 100* completeError(:, bestPos);
bestPop = 100* completePopResult(:, bestPos);
bestPopError = 100* completePopError (:, bestPos);
bestParam = completeParams(bestPos, :);



end

