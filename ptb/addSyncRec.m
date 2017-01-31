function ptb = addSyncRec(ptb,addToSave)
	Screen('FillRect',ptb.win,[0 0 0],[0 ptb.yRes-45 45 ptb.yRes])
    if exist('addToSave','var') && addToSave
        ptb = saveWin(ptb);
    end
end