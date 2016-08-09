function ptb = loadWin(ptb,saveSlot)
%loads the screen from the save slot and the default save slot if no saveSlot supplied, see saveWin
    if ~exist('saveSlot','var')
        saveSlot = 1;   
    end
    Screen('CopyWindow',ptb.savedWin{saveSlot},ptb.win)
end
