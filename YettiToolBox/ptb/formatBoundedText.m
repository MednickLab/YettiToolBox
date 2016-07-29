function [text,fits,textBounds] = formatBoundedText(ptb,x,y,text)
%This function formats text with linebreaks (\n\n) so that it fits in the bounds
%given by x. Also returns if the formatted version *fits* inside the given
%y as well as the new shape of text *textBounds*\
    ptb = saveWin(ptb,ptb.boundedTextSlot);
    lBreak = '\n\n';
    textStripped = strrep(text,'\n\n','<nl>');
    textStripped = stripFormatChars(textStripped);
    charsThatFits = length(textStripped);
    %first check if there is a problem
    [~,~,textBounds] = DrawFormattedText(ptb.win,textStripped(1:charsThatFits),'center','center');
    currentX = textBounds(3)-textBounds(1);
    if currentX < x
        fits = true; 
        clearScreen(ptb.win,true);
        loadWin(ptb,ptb.boundedTextSlot);
        return;
    end
    charsThatFits = 2; %start from front, its faster...
    while(1)
        [~,~,textBounds] = DrawFormattedText(ptb.win,textStripped(1:charsThatFits),'center','center');
        currentX = textBounds(3)-textBounds(1);
        if currentX > x
            break;
        else
            charsThatFits = charsThatFits+1;
        end
    end
    charsThatFits = charsThatFits - 3; %to give a bit of padding...
    %we now have the size that fits
    cutIdx = charsThatFits;
    lastCut = false;
    
    text = strrep(text,' \n\n ','<nl>');
    text = strrep(text,'\n\n ','<nl>');
    text = strrep(text,' \n\n','<nl>');           
    text = strrep(text,'\n\n','<nl>');
    [spaceTextParts] = strsplit(text,'<nl>');
    for sp = 1:length(spaceTextParts)
        sp
        if isempty(spaceTextParts{sp})
            continue;
        end     
        if length(spaceTextParts{sp}) > charsThatFits
            while (1)
                if ~strcmp(' ',spaceTextParts{sp}(cutIdx)) || cutIdx==length(spaceTextParts{sp}) %find spaces to break on
                    cutIdx = cutIdx-1;
                    if cutIdx < 1
                        warning('Text does not fit in Rect')
                        break
                    end
                else %we have a space
                    spaceTextParts{sp} = strinsrt(spaceTextParts{sp},cutIdx,lBreak);
                    if lastCut || (length(spaceTextParts{sp}) - cutIdx) < charsThatFits
                        break;
                    end
                    cutIdx = cutIdx + length(lBreak) + charsThatFits; %set up for next cut
                    if cutIdx > length(spaceTextParts{sp}) %stop indexing past end of text
                       cutIdx = length(spaceTextParts{sp}); 
                    end
                    if (length(spaceTextParts{sp}) - cutIdx) < charsThatFits %check if this is the last cut needed
                        lastCut = true;
                    end
                end
            end
        end
        if ~exist('finalText','var')
            finalText = spaceTextParts{sp};
        else
            finalText = [finalText '<nl>' spaceTextParts{sp}];
        end
    end
    text = strrep(finalText,'\n\n\n\n','\n\n');
    text = strrep(text,'<nl>','\n\n');
    textStripped = strrep(text,'<nl>','\n\n');
    textStripped = stripFormatChars(textStripped);
    [~,~,textBounds] = DrawFormattedText(ptb.win,textStripped,'center','center');
    currentY = textBounds(4)-textBounds(2);
    fits = currentY < y;
    clearScreen(ptb.win,true);
    loadWin(ptb,ptb.boundedTextSlot);
end