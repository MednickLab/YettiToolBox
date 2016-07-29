function drawFixationCross(ptb, fixSize)
    if ~exist('fixSize')
        fixSize = 10;
    end
    fixXCoords = [-fixSize fixSize 0 0];
    fixYCoords = [0 0 -fixSize fixSize];
    fixAllCoords = [fixXCoords; fixYCoords];
    fixLineWidthPix = 2;
    Screen('DrawLines', ptb.win, fixAllCoords, fixLineWidthPix, [255 0 0], [ptb.cx ptb.cy]);
end