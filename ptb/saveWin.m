function ptb = saveWin(ptb,saveSlot)
%saves the current screen (call before flip) for later use, see loadWin for
%loading back into current win
    if ~exist('saveSlot','var')
        saveSlot = 1;   
    end
    Screen('CopyWindow',ptb.win,ptb.savedWin{saveSlot})
end