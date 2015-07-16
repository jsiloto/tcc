% [worse, worsePos] = max(eval);
% err(worsePos) = []
% eval(worsePos) = []
% maxAtt(worsePos) = []
% midAtt(worsePos) = []
% phase(worsePos) = []
% bw(worsePos) = []

all = [eval err bw midAtt maxAtt phase];

[Y,I]=sort(all(:,1));

sorted = all(I, :);
% scatter( sorted(:, 3), sorted(:, 6));
pointsize = 10;
scatter(sorted(:, 3), sorted(:, 5)-sorted(:, 4), pointsize, sorted(:, 1), '.');

x = sorted(:, 3);
y = sorted(:, 5)-sorted(:, 4);
z = sorted(:, 1);

scatter3(x,y,z,9,z, '*');
% Add title and axis labels
title('1600 Samples')
xlabel('BW')
ylabel('MaxAtt - MidAtt')
zlabel('BER')
colormap(jet); %# or other colormap