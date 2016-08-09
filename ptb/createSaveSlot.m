function [ptb,slotNum] = createSaveSlot(ptb)
    ptb.savedWin{length(ptb.savedWin)+1} = Screen('OpenOffscreenWindow',-1);
    slotNum = length(ptb.savedWin);
end