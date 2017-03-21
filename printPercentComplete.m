function printPercentComplete(currentLoop,totalLoops,initTime)
    status = round(linspace(0,totalLoops,100))==currentLoop;
    if any(status)
        if exist('initTime','var')
            timeElapsed = GetSecs()-initTime;
            timeRemaining = timeElapsed*(totalLoops-currentLoop)/currentLoop;
            dispstat(sprintf('Percent Complete: %.1f%%, Time Remaining %.1f mins',find(status),timeRemaining/60),'timestamp');
        else
            dispstat(sprintf('Percent Complete: %.1f%%',find(status)),'timestamp');
        end
    end
end