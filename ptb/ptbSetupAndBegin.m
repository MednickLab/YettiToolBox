function [ptb] = ptbSetupAndBegin(screenNum,screenChecksOff)
%setup standard psychtoolbox stuff
    if ~exist('screenNum','var')
        screenNum=0;  % which screen to put things on
    end
    if ~exist('screenChecksOff','var')
        screenChecksOff=false;  % which screen to put things on
    end
    if screenChecksOff
        ptb.oldEnableFlag = Screen('Preference', 'SuppressAllWarnings', 1); % Setting this preference to 1 suppresses the printlogger of warnings.
        Screen('Preference', 'SkipSyncTests', 1);
        ptb.origScreenLevel = Screen('Preference','Verbosity',1);  % Set to less verbose loggerput
    end
    ptb.oldEnableFlag = Screen('Preference', 'SuppressAllWarnings', 1); % Setting this preference to 1 suppresses the printlogger of warnings.
    Screen('Preference', 'SkipSyncTests', 1);
    ptb.origScreenLevel = Screen('Preference','Verbosity',1);  % Set to less verbose loggerput
    ptb.screen = screenNum;
    ptb.win = Screen(screenNum,'OpenWindow');  % Open the screen
    ptb.slack = Screen('GetFlipInterval', ptb.win)/2;    
    ptb.savedWin{1} = Screen('OpenOffscreenWindow',-1);
    [ptb,ptb.formatTextSlot] = createSaveSlot(ptb);
    [ptb,ptb.boundedTextSlot] = createSaveSlot(ptb);
    [ptb.xRes,ptb.yRes,ptb.cx,ptb.cy] = getScreenVars(screenNum);
    if ptb.xRes > 1800
        ptb.mainTextSize = 60;
        ptb.percentTextSize = 42;
        ptb.buttonTextSize = 32;      
    else
        ptb.mainTextSize = 32;
        ptb.percentTextSize = 24;
        ptb.buttonTextSize = 16;
    end
    Screen('TextSize',ptb.win,ptb.mainTextSize);
    Screen('TextFont',ptb.win,'Arial');
    initKB();
    HideCursor;
    

       
    %mouse states
    MOUSE_INIT = -1;
    MOUSE_OFF = 0; %no mouse input
    MOUSE_CLICKED = 1; %mouse has just been pressed down
    MOUSE_RELEASED = 2; %mouse has just been released
    MOUSE_DRAG = 3; %mouse has been down for some *Drag time* - see getMouseState.m
    ptb.mouseState = MOUSE_INIT; %init mouse state, this will cause mouse init in the getMouseState function
    ptb.oldMouseState = MOUSE_INIT; %set old mouse state to something safe
    ptb.rightMouse = MOUSE_OFF;
end