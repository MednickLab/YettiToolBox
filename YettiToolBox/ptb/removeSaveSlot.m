function [ptb] = removeSaveSlot(ptb,saveSlot)
    Screen(ptb.savedWin{saveSlot},'Close')
    ptb.savedWin(saveSlot) = [];
end