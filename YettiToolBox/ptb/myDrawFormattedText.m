function [nx,ny,finalTextBounds] = myDrawFormattedText(ptb,text,textX,textY,color)
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
    textStripped = strrep(textStripped,'<nl>','\n\n');
    [nx,ny,finalTextBounds] = DrawFormattedText(ptb.win,textStripped,textX,textY,color); %%find out where this would have started if it was all normal
    ptb = loadWin(ptb,ptb.formatTextSlot);
    formatChars = {'<n>','</n>','<i>','<b>','</b>','<u>','</u>'};
    text = strrep(text,' \n\n ','<nl>');
    text = strrep(text,'\n\n ','<nl>');
    text = strrep(text,' \n\n','<nl>');           
    text = strrep(text,'\n\n','<nl>');
    [spaceTextParts] = strsplit(text,'<nl>');
    
    for sp = 1:length(spaceTextParts)
        if isempty(spaceTextParts{sp})
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
        textY = textBounds(4) + ptb.mainTextSize;
    end
end