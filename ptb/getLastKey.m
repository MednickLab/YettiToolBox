function [key,timeOfPress] = getLastKey() 
    [pressed, firstPress, firstRelease, lastPress, lastRelease]=KbQueueCheck; %  check if any key was pressed.
    if pressed %if key was pressed do the following
        lastPress(lastPress==0)=NaN; %little trick to get rid of 0s
        [timeOfPress,index]=min(lastPress); % gets the RT of the first key-press and its ID         
        key=KbName(index); %converts KeyID to keyname
        index
        if isempty(strfind('MAC',computer)) && index>=30 && index<=39
            key = key(1);
        elseif index>=47 && index<=57
            key = key(1);
        end
    else
        key = NaN;
        timeOfPress = NaN;
    end
end