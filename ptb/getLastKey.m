function [key,timeOfPress] = getLastKey()
    %Check what the last key that was pressed is, return it and the time it
    %was pressed. Note that this function will clear the kb queue
    [pressed, ~, ~, lastPress, ~]=KbQueueCheck; %  check if any key was pressed.
    if pressed %if key was pressed do the following
        lastPress(lastPress==0)=NaN; %little trick to get rid of 0s
        [timeOfPress,index]=min(lastPress); % gets the RT of the first key-press and its ID      
        key=KbName(index); %converts KeyID to keyname
        if ~isempty(strfind(computer,'MAC')) && index>=30 && index<=39
            key = key(1);
        elseif index>=47 && index<=57
            key = key(1);
        end
    else
        key = NaN;
        timeOfPress = NaN;
    end
end