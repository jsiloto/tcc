% [worse, worsePos] = max(eval);
% err(worsePos) = []
% eval(worsePos) = []
% maxAtt(worsePos) = []
% midAtt(worsePos) = []
% phase(worsePos) = []
% bw(worsePos) = []

close all

fontSize = 14;
markerSize = 14;

set(0,'DefaultAxesFontSize',fontSize)
set(0,'DefaultScatterSizeData',markerSize)
set(0, 'DefaultLineMarkerSize', 9)
set(0, 'DefaultLineLineWidth', 2)
% set(0,'DefaultScatterSizeData',14)
% set(0,'DefaultScatterLineWidth',14)
%  set(0,'DefaultFontsize',14) 

filename1 = 'final/evalLog_06_25.txt';
filename2 = 'final/evalLog_06_29.txt';
filename3 = 'final/evalLog_06_30.txt';
filename4 = 'final/evalLog_07_01.txt';

filenameTeste = 'final/evalTeste.txt';


[eval  bw midAtt maxAtt phase]  = parseEval(filename3);
all = [eval  bw midAtt maxAtt phase];
thresh = 0.4;
indices = find(abs(all(:, 1))> thresh);
all(indices, :) = [];
eval = all(:, 1);
bw = all(:, 2);
midAtt = all(:, 3);
maxAtt = all(:, 4);
phase = all(:, 5);




%%%%%%%%%%%%%%% gplot %%%%%%%%%%%%%%%%%
varNames = {'BW'; 'midAtt'; 'maxAtt'; 'phase'};
X = [  bw midAtt maxAtt phase ];
randp = randperm(size(X, 1), floor(size(X, 1)/1));
X = X(randp, :);
eval = eval(randp, :);
evalRound = round(eval(:)*5000)/5000;
minjet = downsample(jet,4);
figure
[h, ax, b] = gplotmatrix(X,[],evalRound,minjet,[],4,false);

text(0.1:0.25:1, repmat(-.1,1,4), varNames, 'FontSize',fontSize);
text(repmat(-.12,1,4), [0.85:-0.25:0], varNames, 'FontSize',fontSize, 'Rotation',90);
% colormap(jet); %# or other colormap



%%%%%%%%%%%%%%% PCA %%%%%%%%%%%%%%%%%

all = [eval X(:, 1:end-1)];

[pc,score,latent,tsquare] = princomp(all);
pc,latent
latent./sum(latent)
cumsum(latent)./sum(latent)

figure
biplot(pc(:,1:2),'Scores',score(:,1:2),'VarLabels',...
		{'Eval' 'BW' 'MidAtt' 'MaxAtt'})

figure
biplot(pc(:,1:3),'Scores',score(:,1:3),'VarLabels',...
		{'Eval' 'BW' 'MidAtt' 'MaxAtt'})
    
   
%%%%%%%%%%%%%%% Scatter3d %%%%%%%%%%%%%%%%%
[Y,I]=sort(all(:,1));
sorted = all(I, :);

% scatter( sorted(:, 3), sorted(:, 6));
pointsize = 10;

x = sorted(:, 2);
y = sorted(:, 4)-sorted(:, 3);
z = sorted(:, 1);

figure
s = scatter3(x,y,z,markerSize,z, '*');
% Add title and axis labels

numSamples = size(x, 1);
t = num2str(numSamples);
t =strcat(t,' Samples');
title(t)
xlabel('BW')
ylabel('MaxAtt - MidAtt')
zlabel('BER')
colormap(jet); %# or other colormap