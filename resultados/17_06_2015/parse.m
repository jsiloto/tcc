numEval =  500;
recordInterval = 10;
numRuns = 20;
numSamples = numEval/recordInterval;

evalNum = recordInterval:recordInterval:numEval;
completeParams = [];
completeResult = [];
fid = fopen('holder.txt');
run = [];
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
    [ MLE, errBar ] = process(allruns, evalNum);
    
    if strcmp(paramsstr, '10 0.5 0.05 0.05')
        NSA = [ MLE, errBar ]
    end
    if strcmp(paramsstr, '10 0.8 0.1 0.1')
        NSB = [ MLE, errBar ]
    end
    if strcmp(paramsstr, '10 0.8 0.7')
        DiffA = [ MLE, errBar ]
    end   
    if strcmp(paramsstr, '6 3 0.6 0.4 0.1')
        optA = [ MLE, errBar ]
    end
    completeParams = strvcat(completeParams, paramsstr)
    completeResult = [ completeResult; [MLE(5) errBar(5) MLE(20) errBar(20)]];
end

figure
hold on
plot(evalNum,NSA(:,1),'-.r',...
                'LineWidth',1)
plot(evalNum,NSB(:,1),'--b',...
                'LineWidth',1)
plot(evalNum,DiffA(:,1),':k',...
                'LineWidth',1)
plot(evalNum,optA(:,1),'-g',...
                'LineWidth',1)
legend('NSGAII-1','NSGAII-2','DE', 'Opt-aiNet')
title('holder')
xlabel('Number of Evaluations') % x-axis label
ylabel('Mean Logarithmic Error') % y-axis label

% plot(evalNum,NSA(:,1),'-ro',... %'LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',10,...
%      evalNum,NSB(:,1),'-bs',...
%      evalNum, DiffA(:,1),'-g+',...
%      evalNum,optA(:,1) ,'-yx');


figure
plot(x,y1,'-ro',x,y2,'-.b')
legend('sin(x)','cos(x)')
% , '-gd' ,'-yt'

figure
h =errorbar(evalNum, NSA(:,1), NSA(:,2), 'b');
h =errorbar(evalNum, NSB(:,1), NSB(:,2), 'r');
h =errorbar(evalNum, DiffA(:,1), DiffA(:,2), 'y');
h =errorbar(evalNum, optA(:,1), optA(:,2), 'm');


completeParams

completeResult










