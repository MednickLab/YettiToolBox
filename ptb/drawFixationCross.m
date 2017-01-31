function drawFixationCross(ptb, color, fixSize)
    if ~exist('fixSize','var')
        fixSize = 10;
    end
    if ~exist('color','var') || isempty(color)
        color = ptb.textColor;
    end
    fixXCoords = [-fixSize fixSize 0 0];
    fixYCoords = [0 0 -fixSize fixSize];
    fixAllCoords = [fixXCoords; fixYCoords];
    fixLineWidthPix = 2;
    Screen('DrawLines', ptb.win, fixAllCoords, fixLineWidthPix, color, [ptb.cx ptb.cy]);
end