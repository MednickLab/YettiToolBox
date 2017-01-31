function [back0,back1,back2] = calcTransitionProbs(epochStage)
%Calculates the transition probabilities (via MLE) of a sleep episode. Currently just one back trans
%i.e. P(NS=X | 1Back=Y). Returns 6 by nBack matrix of transition probabilities
%where row=1Back state, and col=NS and
%1=WASO,2=Stage1,3=Stage2,4=SWS,5=REM,6=Wake (Sleep Onset)
    sleepPeriods = consecutiveValues(epochStage);
    sleepPeriods.vals = sleepPeriods.vals;
    numTransitions = length(sleepPeriods.vals);
    offsetStart = 2;
    back0 = zeros(6,1);
    back1 = zeros(6,5);
    back2 = zeros(6,5,5);
    if numTransitions < offsetStart+1
        disp('Sleep Ep to short:')
        return;
    end
    for d=1:numTransitions %because we need to start 3 back (ps,cs,ns)
        back0(sleepPeriods.vals(d)) = back0(sleepPeriods.vals(d))+1;
        if d+1 <= numTransitions
            back1(sleepPeriods.vals(d),sleepPeriods.vals(d+1))=back1(sleepPeriods.vals(d),sleepPeriods.vals(d+1))+1; 
        end
        %back2(sleepPeriods.vals(d),sleepPeriods.vals(d+1),sleepPeriods.vals(d+2))=back2(sleepPeriods.vals(d),sleepPeriods.vals(d+1),sleepPeriods.vals(d+2))+1;
    end
    back0 = back0(1:end-1)/sum(back0(1:end-1));
    back1 = back1./repmat(sum(back1,2),1,size(back1,2));
    %back2 = back2./repmat(sum(back2')',1,size(back2,2)); %FIXME
end