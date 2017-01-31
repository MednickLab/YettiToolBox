function [woWake,wWake] = calcStageProportions(epochStage)
%Calculates the propotions in each stage of a sleep episode. 
%1=WASO,2=Stage1,3=Stage2,4=SWS,5=REM,6=Wake (Sleep Onset)
    props = accumarray(epochStage',ones(size(epochStage)));
    distProps = zeros(1,6);
    distProps(1:max(epochStage)) = props;
    wWake = distProps/sum(distProps);
    woWake = distProps(1:end-1)/sum(distProps(1:end-1));
    %back2 = back2./repmat(sum(back2')',1,size(back2,2)); %FIXME
end