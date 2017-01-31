function initKB()
    %Initialize the key board
    ListenChar(0)
    KbName('UnifyKeyNames'); %used for cross-platform compatibility of keynaming
    KbQueueCreate; %creates cue using defaults
    warning('off','all')
    ListenChar(2) %makes it so characters typed don?t show up in the command window
    warning('on','all')
    KbQueueStart;  %starts the cue
end

