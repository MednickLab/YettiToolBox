function finalTextBounds = myFormatStyle(ptb,text,textX,textY,color)
    ptb = saveWin(ptb,ptb.formatTextSlot);  
    if isempty(text)
        finalTextBounds = [0 0 0 0];
        return
    end
    if ~exist('color','var')
        color = [ 0 0 0 ];
    end
    formatChars = {'<n>','</n>','<i>','<b>','</b>','<u>','</u>'};
    formats = {'<n>','<b>','<i>','missing','<u>'};
    textStripped = stripFormatChars(text);
    textStripped = strrep(textStripped,'<nl>','\n\n');
    [~,~,finalTextBounds] = DrawFormattedText(ptb.win,textStripped,textX,textY,color); %%find out where this would have started if it was all normal
    if strcmp(textX,'center')    
        textX = finalTextBounds(1);
    end
    [formatTextParts,matches] = strsplit(text,formatChars);  
    if isempty(formatTextParts{1}) || strcmp(formatTextParts{1},' ');
        formatTextParts = formatTextParts(2:end);
    end
    if ~isempty(formatTextParts)
        Screen(ptb.win,'FillRect',[255 255 255]);
        ptb = loadWin(ptb,ptb.formatTextSlot);
        for p = 1:length(formatTextParts)
            if ~isempty(matches)
                matches{p} = matches{p}(end-2:end); %remove double format chars and just keep the last one
                style = find(strcmp(matches{p},formats))-1;
                Screen(ptb.win,'TextStyle',style);
            end
            [~,~,tBounds] = DrawFormattedText(ptb.win,formatTextParts{p},textX,textY,color); %text is all on same level, so Y does not change
            textX = tBounds(3);
%             if ~isempty(strfind(computer,'WIN')) %windozes and mac behave differnly. Why? Fucking dont know mate... silly!
%                 
%             else
%                 textX = textBounds(4);                    
%             end
        end
        Screen(ptb.win,'TextStyle',0); %reset syle
    end
end