function [nx,ny,finalTextBounds] = myDrawFormattedText(ptb,text,textX,textY,color)
%Adds style formatting to text that contains format tags:
%<n>=normal,<b>=bold,<u>=underline,<i>=italices,<nl>=newline tags
%All other behavor should be as DrawFormattedText
%BYNOTE: Code developed with Psychtoollbox version 3.0.12. Note that later versions of psychtoolbox use the y input of DrawFormattedText as baseline
% Please edit line 286 of DrawFormattedText to "yPosIsBaseline = 0;" to make later versions of Psychtoolbox compadable
    ptb = saveWin(ptb,ptb.formatTextSlot);
    if isempty(text)
        nx=0;
        ny=0;
        finalTextBounds = [0 0 0 0];
        return
    end
    if ~exist('color','var') || isempty(color)
        color = [ 0 0 0 ];
    end
    
    formatChars = {'<n>','</n>','<i>','<b>','</b>','<u>','</u>'};
    textStripped = stripFormatChars(text);
    textStripped = strrep(textStripped,'<nl>',ptb.lineBreak);
    [nx,ny,finalTextBounds] = DrawFormattedText(ptb.win,textStripped,textX,textY,color); %%find out where this would have started if it was all normal
    [~,singleLine] = DrawFormattedText(ptb.win,'X',0,0);
    [~,doubleLine] = DrawFormattedText(ptb.win,['X' ptb.lineBreak 'X'],0,0);
    lineBreakHeight = doubleLine-singleLine;
    textY = finalTextBounds(2);
    ptb = loadWin(ptb,ptb.formatTextSlot);          
    text = strrep(text,ptb.lineBreak,'<nl>');
    [spaceTextParts] = strsplit(text,'<nl>');
    
    if isempty(spaceTextParts{1}) %TODO check this
        spaceTextParts = spaceTextParts(2:end);
    end
    for sp = 1:length(spaceTextParts)
        if isempty(spaceTextParts{sp})
            textY = textY + lineBreakHeight;
            continue;
        end
         
        %if we have format chars in the middle of slices, then we will need
        %to move the front of the next slice too, so to carry on that format on the next line
        if sp+1 <= length(spaceTextParts)
            [~,matches] = strsplit(spaceTextParts{sp},formatChars);
            if ~isempty(matches)
                spaceTextParts{sp+1} = [matches{end} spaceTextParts{sp+1}];
            end
        end
        textBounds = myFormatStyle(ptb,spaceTextParts{sp},textX,textY,color);
        if IsWin
            textY = textBounds(4) + lineBreakHeight;
        else
            textY = textBounds(2) + lineBreakHeight;
        end
    end
end