function text = openExternalTextbox(numLines,numChars)
    KbQueueRelease()
    ShowCursor()
    ListenChar(0)   
    text = inputdlg('Enter space-separated numbers:',...
             'Sample', [numLines numChars]);
    initKB();     
end