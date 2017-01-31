function [meanDurations,distDurations] = calcDurationDists(epochStage,plot,bins)
    %calcs (and plots) Duration Dstributions from hypnogram like formatted data
    %1=WASO,2=Stage1,3=Stage2,4=SWS,5=REM,6=Wake (Sleep Onset)
    if ~exist('bins','var')
        bins = [0:5:45 inf];
    end
    stageNames = {'WASO','1','2','SWS','REM','Wake'};
    epochLength = 0.5;
    sleepPeriods = consecutiveValues(epochStage);
    sleepPeriods.lengthSeqs = sleepPeriods.lengthSeqs*epochLength;    
    meanDurations = arrayfun(@(x) mean(sleepPeriods.lengthSeqs(sleepPeriods.vals==x)),1:6);
    distDurations = arrayfun(@(x) histcounts(sleepPeriods.lengthSeqs(sleepPeriods.vals==x),bins),1:6,'UniformOutput',false);
    if exist('plot','var') && plot
        for s=1:6
            subplot(1,6,s)
            histogram(sleepPeriods.lengthSeqs(sleepPeriods.vals==s),bins,'Normalization','probability');
            title(stageNames{s});
        end
    end
end