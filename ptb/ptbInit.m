function [ptb] = ptbInit(screenNum,screenChecksOff)
%setup standard psychtoolbox stuff
    if ~exist('screenNum','var')
        screenNum=0;  % which screen to put things on
    end
    if ~exist('screenChecksOff','var')
        screenChecksOff=false;  % which screen to put things on
    end
    ptb.screenChecksOff = screenChecksOff;
    if screenChecksOff
        ptb.oldEnableFlag = Screen('Preference', 'SuppressAllWarnings', 1); % Setting this preference to 1 suppresses the printlogger of warnings.
        Screen('Preference', 'SkipSyncTests', 1);
        ptb.origScreenLevel = Screen('Preference','Verbosity',1);  % Set to less verbose loggerput
    end
    ptb.screen = screenNum;
    Screen('Preference', 'WindowShieldingLevel',2000); %2000=normal
    ptb.win = Screen(screenNum,'OpenWindow');  % Open the screen
    ptb.slack = Screen('GetFlipInterval', ptb.win)/2; 
    ptb.speedUp = 1; %speed up run time thoughtout tasks. Divide by this number when specifying times
    ptb.savedWin{1} = Screen('OpenOffscreenWindow',-1);
    if ~isempty(strfind(computer,'WIN'))
        ptb.lineBreak = '\n\n';
    else
        ptb.lineBreak = '\n';
    end
    [ptb,ptb.formatTextSlot] = createSaveSlot(ptb);
    [ptb,ptb.boundedTextSlot] = createSaveSlot(ptb);
    [ptb.xRes,ptb.yRes,ptb.cx,ptb.cy] = getScreenVars(screenNum);
    
    if ptb.xRes > 2000
        ptb.mainTextSize = 60;
        ptb.percentTextSize = 42;
        ptb.buttonTextSize = 32;      
    else
        ptb.mainTextSize = 36;
        ptb.percentTextSize = 24;
        ptb.buttonTextSize = 20;
    end
    Screen('TextSize',ptb.win,ptb.mainTextSize);
    Screen('TextFont',ptb.win,'Arial');
    ptb.textColor = [0 0 0];
    ptb.bgColor = [255 255 255];
    %% sound
%     ptb.audioSampleRate = 44100;
%     InitializePsychSound(1); 
%     ptb.audioPort = PsychPortAudio('Open', [], [], [], ptb.audioSampleRate,1);
    %% Input
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
    ptb = getMouseState(ptb); %init mouse
end