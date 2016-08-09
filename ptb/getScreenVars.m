function [xRes,yRes,cx,cy] = getScreenVars(screenNum)
    %gets useful pychtoolbox screen variables:
    % -xRes
    % -yRes
    % -xCenter
    % -yCenter
    [xRes, yRes] = Screen('WindowSize',screenNum);
    cx = xRes/2;
    cy = yRes/2;

end