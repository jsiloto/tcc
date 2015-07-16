numEval =  500;
recordInterval = 10;
numRuns = 50;
numSamples = numEval/recordInterval;

evalNum = recordInterval:recordInterval:numEval;
completeParams = [];
completeResult = [];
fid = fopen('compactResultLog.txt');
run = [];
while 1
    paramName = fgetl(fid);
    if paramName == -1
        break
    end
    if isempty(paramName)
        break
    end
    isname = strfind(paramName, 'pop');
    
    paramsstr = fgetl(fid);
    param = strread(paramsstr);
    
    
    
    tline = fgetl(fid);
    eval = strread(tline);
    allruns = [];
    for thisRun =1:numRuns
        %get one run
        run = [];
        while 1
            run = [run; eval];
            tline = fgetl(fid);
            if isempty(tline)
                break
            end
            if tline == -1
                break
            end
            eval = strread(tline);
            if eval(1) == 10
                break
            end
        end
        run = fixVector(run, numSamples);
        allruns = [allruns run(:, 3)];
    end
    [ MLE, errBar ] = process(allruns, evalNum);
    completeParams = strvcat(completeParams, paramsstr)
    completeResult = [ completeResult; [MLE(5) errBar(5) MLE(20) errBar(20)]];
end


completeParams

completeResult










