function [clicked,timeOfClick] = drawButton(ptb,loc,text,type,textX,textY,buttonColor)
%draws a selectable button on the backbuffer. may contain text. This function should run in a loop. Note that
%timing is inaccurate see comment below
    if ~exist('type','var') || isempty(type)
    	type='FillRect'; 
    end
    if ~exist('textX','var') || isempty(textX)
    	textX=loc(1)+1; 
    end
    if ~exist('textY','var') || isempty(textY)
    	textY=loc(2)+1; 
    end
    if ~exist('buttonColor','var')
        buttonColor = [200 200 200];
    end
    clicked = false;
    timeOfClick = nan;
    if locInRect(ptb.x,ptb.y,loc)
        Screen(type, ptb.win, buttonColor*3/4,loc)
        Screen('FrameRect', ptb.win, [0 0 255],loc)      
        if ptb.mouseState == 1
            clicked = true;
            timeOfClick = GetSecs(); %whats the detlay between click check and here?! TODO
            return
        end
    else
        Screen(type, ptb.win, buttonColor,loc)
    end
    DrawFormattedText(ptb.win, text,textX,textY);
end