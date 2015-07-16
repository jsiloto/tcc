function [ MLE, errBar ] = process( input, evalNum )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

error = input;
meanError = mean(error, 2);
errorLog = log10(abs(error));

MLE = mean(errorLog, 2);
errBar = std(errorLog,0, 2);
h =errorbar(evalNum, MLE, errBar, 'b');
s = h.LineStyle;
h.MarkerFaceColor = 'r';
h.LineStyle = ':';
h.Color = 'r';


end

