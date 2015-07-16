numEval =  500;
recordInterval = 10;
numRuns = 100;
numSamples = numEval/recordInterval;

evalNum = recordInterval:recordInterval:numEval;
completeParams = [];
completeResult = [];
completeResultME = [];
completeMLE = [];
completeMLS = [];
bestEnd = [];
fid = fopen('opt.txt');
run = [];
baseStr = fgetl(fid);
baseline = strread(baseStr);


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
    
    completeParams = strvcat(completeParams, paramsstr);
    
    [ MLE, errBar ] = processMLE(allruns, evalNum);
    bestEnd = [ bestEnd; [MLE(end) errBar(end)]];
    completeMLE = [completeMLE MLE];
    completeMLS = [completeMLS errBar];
end
bestEnd
completeParams
[a, bestDEPos] = min(bestEnd(1:6, 1));
[a, bestOptPos] = min(bestEnd(7:12, 1));
[a, bestGAPos] = min(bestEnd(13:18, 1)) ;

bestDEPos
bestOptPos = bestOptPos+ 6
bestGAPos = bestGAPos + 12

bestDE = [completeMLE(:, bestDEPos) completeMLS(:, bestDEPos)];
bestOpt = [completeMLE(:, bestOptPos) completeMLS(:, bestOptPos)];
bestGA = [completeMLE(:, bestGAPos) completeMLS(:, bestGAPos)];


bestDE = [completeMLE(:, bestDEPos) completeMLS(:, bestDEPos)];
bestOpt = [completeMLE(:, bestOptPos) completeMLS(:, bestOptPos)];
bestGA = [completeMLE(:, bestGAPos) completeMLS(:, bestGAPos)];




%%%%% GET BEST RESULTS %%%%%
i = 1;
hold off
figure

hold on;
markerSize = 7;
LineWidth = 1.3;
offset = 2;
color = [[0,0.7,0.2]; [0.7,0,0.9]; [0.9, 0,0.2]];


hE =errorbar(evalNum, bestDE(:, 1), bestDE(:, 2));
set(hE                            , ...
  'Color'           ,color(i, :)  , ...
  'LineStyle'       , '--'        , ...
  'LineWidth'       , LineWidth        , ...
  'Marker'          , 'o'         , ...
  'MarkerSize'      , markerSize           , ...
  'MarkerEdgeColor' , 'k'  , ...
  'MarkerFaceColor' , color(i, :)  );

i = i+1;
evalNum = evalNum -offset;
hE =errorbar(evalNum, bestOpt(:, 1), bestOpt(:, 2));

set(hE                            , ...
  'Color'           ,color(i, :)  , ...
  'LineStyle'       , ':', ...
  'LineWidth'       , LineWidth          , ...
  'Marker'          , 's'         , ...
  'MarkerSize'      , markerSize           , ...
  'MarkerEdgeColor' , 'k'  , ...
  'MarkerFaceColor' , color(i, :)  );
i = i+1;
evalNum = evalNum -offset;
hE =errorbar(evalNum, bestGA(:, 1), bestGA(:, 2));

set(hE                            , ...
  'Color'           ,color(i, :)  , ...
  'LineStyle'       , '-.'        , ...
  'LineWidth'       , LineWidth        , ...
  'Marker'          , '^'         , ...
  'MarkerSize'      , markerSize           , ...
  'MarkerEdgeColor' , 'k'  , ...
  'MarkerFaceColor' , color(i, :)  );


legend('DE', 'OptaiNet','GA');
%legend()
xlabel('Evaluations')
ylabel('BER')
title('Best Individual')







