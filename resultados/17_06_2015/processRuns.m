function [ MLE, errBar ] = Untitled( input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


eval = input(:, 1, 1);
result = input(:, 2, :);
error = input(:, 3, :);
errorLog = log10(abs(error));

MLE = mean(errorLog, 3);
errBar = std(errorLog,0, 3);
h =errorbar(eval, MLE, errBar, 'b')
s = h.LineStyle;
h.MarkerFaceColor = 'r';
h.LineStyle = ':';
h.Color = 'r'


end

