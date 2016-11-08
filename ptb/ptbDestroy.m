function ptbDestroy(ptb)
%kill exit shutdown and words of that ilk
    Screen('CloseAll');
    %Screen('Preference','Verbosity',screenSetup.origScreenLevel);
    KbDestroy();
    ShowCursor;
    if ptb.screenChecksOff
    	Screen('Preference','SuppressAllWarnings',ptb.oldEnableFlag);
    end
    disp('Thank You')
    fclose('all');
    sca
end