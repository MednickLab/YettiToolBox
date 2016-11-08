function [clicked,timeOfClick] = drawClickableWord(ptb,textX,textY,text,selected)
%draws selectable text on the backbuffer. This function should run in a loop. Note that
%timing is not precise see comment below
    [~,~,textBounds] = DrawFormattedText(ptb.win,[text ptb.lineBreak],textX,textY);
    clicked = false;
    timeOfClick = nan;
    if ptb.mouseState == 1 && locInRect(ptb.x,ptb.y,textBounds)   
        clicked = true;
        timeOfClick = GetSecs(); %whats the delay between click check and here?! TODO
        selected = true;
    end
    
    if selected
       Screen('DrawLine', ptb.win, [200 200 200],textBounds(1),...
           textBounds(2)+(textBounds(4) - textBounds(2))/2, textBounds(3),...
           textBounds(2)+(textBounds(4) - textBounds(2))/2)   
    end
    
end