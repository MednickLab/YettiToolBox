function [key, keypressTime] = KbBlockUntilKeypress(maxTime)
%%Wait until a key is pressed (or *maxTime* is up) before continuing. The time of the *keypressTime *
%%(in ms since epoch) is also returned
    KbQueueFlush();
    [key,keypressTime] = getLastKey();
    startTime = GetSecs();
    while(isnan(key))
        if exist('maxTime','var')
            keypressTime = GetSecs();
            if (keypressTime-startTime) > maxTime
                key = nan;
                break
            end
        end
        [key,keypressTime] = getLastKey();
    end
end