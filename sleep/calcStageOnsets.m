function [sleepOnset,sleepOnsetPerStage] = calcStageOnsets(sleepStages,epochLen)
    %Calculates the onset times for sleep, and then for each stage (sleepOnsetPerStage where 
    % values conrispond to 1=WASO,2=Stage1,3=Stage2,4=SWS,5=REM). 
    %sleepStages must be in format: 1=WASO,2=Stage1,3=Stage2,4=SWS,5=REM,6=Wake (Sleep Onset)
    %epochLen defaults to 0.5 mins.
    if ~exist('epochLen','var')
        epochLen = 0.5;
    end
    sleepOnset = find(sleepStages~=6);
    sleepStages = sleepStages(sleepOnset:end);
    sleepOnset = sleepOnset(1)*epochLen;
    sleepOnsetPerStage = nan(5,1);    
    for s = 1:5
        stageOnset = find(sleepStages==s);
        if ~isempty(stageOnset)
            sleepOnsetPerStage(s) = stageOnset(1)*epochLen;
        end
    end
end