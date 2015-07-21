close all;
numEval =  500;
recordInterval = 10;
numRuns = 200;
evalNum = recordInterval:recordInterval:numEval;



allbests = [];
allbestsPop = [];
allparam = [];

filename = 'test_func/sphere_de.txt'
[best, bestError, bestPop, bestPopError, bestParam ] = parseCompact( numEval, recordInterval, numRuns, filename );
de = {best, bestError, bestPop, bestPopError, bestParam }


%%%%% GET BEST RESULTS %%%%%

file = [3 6 11];
markerSize = 10;
LineWidth = 2;
offset = 0.4;

color = [[0,0.7,0.2]; [0.7,0,0.9]; [0.9, 0,0.2]];
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

