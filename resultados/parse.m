close all;
numEval =  100;
recordInterval = 5;
numRuns = 10;
evalNum = recordInterval:recordInterval:numEval;
f = figure
hold on;

evalNum = evalNum(2:end);

formatSpec = '13_07_2015/%d/log/compactResultLog.txt';

allbests = [];
allbestsPop = [];
allparam = [];

%%%%%%%%%%%%%%%%%

for file=1:12
    
    filename = sprintf(formatSpec,file)
    [best, bestError, bestPop, bestPopError, bestParam ] = parseCompact( numEval, recordInterval, numRuns, filename );
  
  allbests = [allbests ; best(end)];
  allbestsPop = [allbestsPop ; bestPop(end)];
  allparam = strvcat(allparam, bestParam);
end

allparam
hold off
allbests


%%%%% GET BEST RESULTS %%%%%
hold on;
color = ['r' 'g' 'b'];

file = [3 6 11];
markerSize = 10;
LineWidth = 2;
offset = 0.4;

color = [[0,0.7,0.2]; [0.7,0,0.9]; [0.9, 0,0.2]];


i = 1;
filename = sprintf(formatSpec,file(i))

[best, bestError, bestPop, bestPopError, bestParam ] = parseCompact( numEval, recordInterval, numRuns, filename );



hE =errorbar(evalNum, bestPop, bestPopError);

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
filename = sprintf(formatSpec,file(i))
[best, bestError, bestPop, bestPopError, bestParam ] = parseCompact( numEval, recordInterval, numRuns, filename );

hE =errorbar(evalNum, bestPop, bestPopError);

set(hE                            , ...
  'Color'           ,color(i, :)  , ...
  'LineStyle'       , ':', ...
  'LineWidth'       , LineWidth          , ...
  'Marker'          , 's'         , ...
  'MarkerSize'      , markerSize           , ...
  'MarkerEdgeColor' , 'k'  , ...
  'MarkerFaceColor' , color(i, :)  );

i = i+1;
filename = sprintf(formatSpec,file(i))
[best, bestError, bestPop, bestPopError, bestParam ] = parseCompact( numEval, recordInterval, numRuns, filename );

evalNum = evalNum -offset;
hE =errorbar(evalNum, bestPop, bestPopError);

set(hE                            , ...
  'Color'           ,color(i, :)  , ...
  'LineStyle'       , '-.'        , ...
  'LineWidth'       , LineWidth        , ...
  'Marker'          , '^'         , ...
  'MarkerSize'      , markerSize           , ...
  'MarkerEdgeColor' , 'k'  , ...
  'MarkerFaceColor' , color(i, :)  );




labels=get(gca,'YTickLabel'); % get the y axis labels;

for i=1:size(labels,1)
   labels_modif(i,:)=strcat(labels(i,:), ' %');
end
set(gca,'YTickLabel',labels_modif)
legend('GA','OptaiNet', 'DE');
xlabel('Evaluations')
ylabel('BER')
title('Best Individual')

result = allparam(file, :)

