load matlab.mat

data = ackley;

numEval =  500;
recordInterval = 10;
numRuns = 20;
numSamples = numEval/recordInterval;

numParameters = 6;
for param = 1:numParameters
    parameters = data(4, :);
    data = data(5:end, :);
    run=zeros(numSamples, 5, numRuns);
    for j = 1:numRuns

        a = data(1:numSamples, :);
        run(:, :, j) = a;
        data = data(numSamples+1:end, :);

    end
    processRuns(run);
end

data = data(3:end, :);

numParameters = 6;
for param = 1:numParameters
    parameters = data(4, :);
    data = data(5:end, :);
    run=zeros(numSamples, 5, numRuns);
    for j = 1:numRuns

        a = data(1:numSamples, :);
        run(:, :, j) = a;
        data = data(numSamples+1:end, :);

    end
    processRuns(run);
end
