function [meanDurations,distDurations,normalizedDistDurations] = calcDurationDists(epochStage,plot,bins,nbins)
    %calcs (and plots) Duration Dstributions from hypnogram like formatted data
    %1=WASO,2=Stage1,3=Stage2,4=SWS,5=REM,6=Wake (Sleep Onset)
    %bins are the bins for all histograms, if left out or empty [], then the default of [0:5:45 inf]
    %will apply. nbins is the number of bins to use, and will use histcounts automatic scalling for
    %the edges
    if ~exist('bins','var') && ~isempty(nbins)
        bins = [0:5:50 inf];
    end
    
    stageNames = {'WASO','Stage 1','Stage 2','SWS','REM','Wake'};
    epochLength = 0.5;
    sleepPeriods = consecutiveValues(epochStage);
    sleepPeriods.lengthSeqs = sleepPeriods.lengthSeqs*epochLength;    
    meanDurations = arrayfun(@(x) mean(sleepPeriods.lengthSeqs(sleepPeriods.vals==x)),1:6);
    if ~exist('nbins','var')
        if iscell(bins)
            distDurations = arrayfun(@(x) histcounts(sleepPeriods.lengthSeqs(sleepPeriods.vals==x),bins{x}),1:6,'UniformOutput',false);
        else
            distDurations = arrayfun(@(x) histcounts(sleepPeriods.lengthSeqs(sleepPeriods.vals==x),bins),1:6,'UniformOutput',false);
        end
    else
        distDurations = arrayfun(@(x) histcounts(sleepPeriods.lengthSeqs(sleepPeriods.vals==x),nbins),1:6,'UniformOutput',false);
    end
    normalizedDistDurations = cellfun(@(x) x/sum(x),distDurations,'UniformOutput',false);
    
    if exist('plot','var') && plot
        for s=1:6
            subplot(1,6,s)
            if ~exist('nbins','var')
                if ~iscell(bins)
                    histogram(sleepPeriods.lengthSeqs(sleepPeriods.vals==s),bins,'Normalization','probability');
                else
                    histogram(sleepPeriods.lengthSeqs(sleepPeriods.vals==s),bins{s},'Normalization','probability');
                end
            else
                histogram(sleepPeriods.lengthSeqs(sleepPeriods.vals==s),nbins,'Normalization','probability');
            end
            title(stageNames{s});
            xlabel('Mins')
            if s==1
                ylabel('Probability Density')
            end
        end
    end
end