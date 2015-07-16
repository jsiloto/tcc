% [worse, worsePos] = max(eval);
% err(worsePos) = []
% eval(worsePos) = []
% maxAtt(worsePos) = []
% midAtt(worsePos) = []
% phase(worsePos) = []
% bw(worsePos) = []

filename1 = 'final/evalLog_06_25.txt';
filename2 = 'final/evalLog_06_29.txt';
filename3 = 'final/evalLog_06_30.txt';
filename4 = 'final/evalLog_07_01.txt';


[eval1 bw1 midAtt1 maxAtt1 phase1] = parseEval(filename1);
[eval2 bw2 midAtt2 maxAtt2 phase2] = parseEval(filename2);
[eval3 bw3 midAtt3 maxAtt3 phase3] = parseEval(filename3);
[eval4 bw4 midAtt4 maxAtt4 phase4] = parseEval(filename3);


eval = [eval1; eval2; eval3; eval4];
bw = [bw1; bw2; bw3; bw4];
midAtt = [midAtt1; midAtt2; midAtt3; midAtt4];
maxAtt = [maxAtt1; maxAtt2; maxAtt3; maxAtt4];
phase = [phase1; phase2; phase3; phase4];

all = [eval bw midAtt maxAtt phase];

randp = randperm(size(all, 1), floor(size(all, 1)/4));
all = all(randp, :);

[Y,I]=sort(all(:,1));

sorted = all(I, :);

thresh = 1.5;
indices = find(abs(sorted(:, 1))> thresh);

sorted(indices, :) = [];

% scatter( sorted(:, 3), sorted(:, 6));
pointsize = 10;

x = sorted(:, 2);
y = sorted(:, 4)-sorted(:, 3);
z = sorted(:, 1);

[pc,score,latent,tsquare] = princomp(sorted(:, 2:end));
pc,latent
cumsum(latent)./sum(latent)
biplot(pc(:,1:2),'Scores',score(:,1:2),'VarLabels',...
		{'BW' 'MidAtt' 'MaxAtt' 'Phase'})

scatter3(x,y,z,9,z, '*');
% Add title and axis labels
title('1600 Samples')
xlabel('BW')
ylabel('MaxAtt - MidAtt')
zlabel('BER')
colormap(jet); %# or other colormap