function [ bestMean, bestStdev, popMean, popStdev, paramName, paramsstr, fEnd] = parseOneParameter( fid, numEval, recordInterval, numRuns )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    fEnd = 0;
    bestMean = [];
    bestStdev = [];
    popMean = [];
    popStdev = [];
    paramName = [];
    paramsstr = [];
    
    numSamples = numEval/recordInterval;

    run = [];
    allBest = [];
    allPop = [];

    [paramName, valid] = getValidLine(fid);
    if ~valid
        fEnd = 1;
        return;
    end
    
    [paramsstr, valid] = getValidLine(fid);
    if ~valid
        fEnd = 1;
        return;
    end
    param = strread(paramsstr);
    
    eval = [];
    allruns = [];
    while 1
        %get one run
        run = [];
        while 1
            if ~isempty(run) && eval(1) == recordInterval
                break
            end
            run = [run; eval];
            [tline, valid] = getValidLine(fid);
            if ~valid
                break;
            end
            eval = strread(tline);
        end
        run = fixVector(run, numSamples);
        allBest = [allBest run(:, 3)];
        allPop = [allPop run(:, 2)];
        if ~valid
            break;
        end
    end

    [bestMean, bestStdev] = process(allBest);
    [popMean, popStdev] = process(allPop);

end

