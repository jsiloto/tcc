close all;
numEval =  500;
recordInterval = 10;
numRuns = 200;
evalNum = recordInterval:recordInterval:numEval;





allbests = [];
allbestsPop = [];
allparam = [];

tic()
formatSpec = 'test_func/%s_%s.txt';

algo = {'de' 'ga' 'opt'}
problem = {'sphere' 'ackley' 'opt' 'holder'}
for p=problem
    p = p{1};
    result = [];
    for a=algo
        a = a{1};
        filename = sprintf(formatSpec,p, a);
        [best, bestError, bestPop, bestPopError, bestParam ] = parseCompact( numEval, recordInterval, numRuns, filename );
        var = {best/100, bestError/100, bestPop/100, bestPopError/100, bestParam };
        result = [result; var];
        bestParam
    end
    printAlgo( result, evalNum, p);
end


toc()
