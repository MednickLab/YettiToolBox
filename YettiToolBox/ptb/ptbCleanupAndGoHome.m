function ptbCleanupAndGoHome(screenSetup)
%kill exit shutdown and words of that ilk
    Screen('CloseAll');
    Screen('Preference','Verbosity',screenSetup.origScreenLevel);
    KbDestroy();
    ShowCursor;
    Screen('Preference','SuppressAllWarnings',screenSetup.oldEnableFlag);
    disp('Thank You')
    fclose('all');
    sca
end