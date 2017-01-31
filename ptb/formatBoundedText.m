function [text,fits,textBounds] = formatBoundedText(ptb,x,y,text)
%This function formats text with linebreaks (\n\n) so that it fits in the bounds
%given by x. Also returns if the formatted version *fits* inside the given
%y as well as the new shape of text *textBounds*\

%BYNOTE: Code developed with Psychtoollbox version 3.0.12. Note that later versions of psychtoolbox use the y input of DrawFormattedText as baseline
% Please edit line 286 of DrawFormattedText to "yPosIsBaseline = 0;" to make later versions of Psychtoolbox compadable

    ptb = saveWin(ptb,ptb.boundedTextSlot);
    textStripped = strrep(text,ptb.lineBreak,'<nl>');
    textStripped = stripFormatChars(textStripped);
    %first check if there is a problem
    [~,~,textBounds] = DrawFormattedText(ptb.win,textStripped,'center','center');
    currentX = textBounds(3)-textBounds(1);
    if currentX < x
        fits = true; 
        clearScreen(ptb.win,true);
        loadWin(ptb,ptb.boundedTextSlot);
        return;
    end
    [~,~,textPixBounds] = DrawFormattedText(ptb.win,'X','center','center');
    textPix = textPixBounds(3)-textPixBounds(1);
    charsThatFit = round(x/textPix); %start from front, its faster...
    while(1)
        [~,~,textBounds] = DrawFormattedText(ptb.win,textStripped(1:charsThatFit),'center','center');
        currentX = textBounds(3)-textBounds(1);
        errorPix = currentX - x;
        charsThatFit = round(charsThatFit-errorPix/textPix);
        if charsThatFit < textStripped
            break
        end
        if abs(errorPix/textPix) < 1
            break
        end
    end
    charsThatFit = charsThatFit - 2; %to give a bit of padding...
    %we now have the size that fits
    cutIdx = charsThatFit;
    lastCut = false;
    
    text = strrep(text,[' ' ptb.lineBreak ' '],'<nl>');
    text = strrep(text,[ptb.lineBreak ' '],'<nl>');
    text = strrep(text,[' ' ptb.lineBreak],'<nl>');          
    text = strrep(text,ptb.lineBreak,'<nl>');
    [spaceTextParts] = strsplit(text,'<nl>');
    for sp = 1:length(spaceTextParts)
        cutIdx = charsThatFit;
        if ~isempty(spaceTextParts{sp})    
            if length(spaceTextParts{sp}) > charsThatFit
                while (1)
                    if ~strcmp(' ',spaceTextParts{sp}(cutIdx)) || cutIdx==length(spaceTextParts{sp}) %find spaces to break on
                        cutIdx = cutIdx-1;
                        if cutIdx < 1
                            warning('Text does not fit in Rect')
                            break
                        end
                    else %we have a space
                        spaceTextParts{sp} = strinsrt(spaceTextParts{sp},cutIdx,ptb.lineBreak);
                        if lastCut || (length(spaceTextParts{sp}) - cutIdx) < charsThatFit
                            break;
                        end
                        cutIdx = cutIdx + length(ptb.lineBreak) + charsThatFit; %set up for next cut
                        if cutIdx > length(spaceTextParts{sp}) %stop indexing past end of text
                           cutIdx = length(spaceTextParts{sp}); 
                        end
                        if (length(spaceTextParts{sp}) - cutIdx) < charsThatFit %check if this is the last cut needed
                            lastCut = true;
                        end
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
    finalText = strrep(finalText,[ptb.lineBreak ptb.lineBreak],ptb.lineBreak);
    text = strrep(finalText,'<nl>',ptb.lineBreak);
    textStripped = strrep(text,'<nl>',ptb.lineBreak);
    textStripped = stripFormatChars(textStripped);
    [~,~,textBounds] = DrawFormattedText(ptb.win,textStripped,'center','center');
    currentY = textBounds(4)-textBounds(2);
    fits = currentY < y;
    clearScreen(ptb.win,true);
    loadWin(ptb,ptb.boundedTextSlot);
end