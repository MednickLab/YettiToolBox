function drawBullsEye(ptb, color, radius)
    if ~exist('radius','var')
        radius = 20;
    end
    if ~exist('color','var') || isempty(color)
        color = ptb.textColor;
    end
    Screen('FillOval', ptb.win, color, [ptb.cx-radius ptb.cy-radius ptb.cx+radius ptb.cy+radius]);
    Screen('FillOval', ptb.win, ptb.bgColor, [ptb.cx-radius*2/3 ptb.cy-radius*2/3 ptb.cx+radius*2/3 ptb.cy+radius*2/3]);
    Screen('FillOval', ptb.win, color, [ptb.cx-radius*1/3 ptb.cy-radius*1/3 ptb.cx+radius*1/3 ptb.cy+radius*1/3]);
end