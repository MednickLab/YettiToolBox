function initSyncTimes = initTaskSync(ptb)       
    flashRate = 0.1;
    colors = {[0 0 0],[255 255 255]};     
    Screen('FillRect',ptb.win,colors{1},[0 ptb.yRes-45 45 ptb.yRes])
    initSyncTimes = zeros(4,1);
    clearScreen(ptb.win)
    initSyncTimes(1) = Screen(ptb.win,'Flip'); 
    for i=2:4
        Screen('FillRect',ptb.win,colors{mod(i,2)+1},[0 ptb.yRes-45 45 ptb.yRes])
        initSyncTimes(i) = Screen(ptb.win,'Flip',initSyncTimes(i-1)+flashRate-ptb.slack);
    end
    WaitUntil(GetSecs()+0.5);
end