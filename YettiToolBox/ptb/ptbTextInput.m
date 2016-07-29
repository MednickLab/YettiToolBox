function [textOut, startTypingTime, endTypingTime] = ptbTextInput(...
    initText,requiredChars, ptb, textColor,textY,dontClear,saveSlot,requiredType,trailingChar,limit)
    %Allows for rendered text input. Init text is the inital text before user types. 
    % Required char's is the required amount of charaters before Enter
    % press will allow return. If dontClear is set then previously saved
    % win will be draw with the text input box, requiredType is either
    % unset (anything) or 'number' whereby only numbers can be entered.
    % TrailingChar are concatinated onto answer (useful for %). Limit is a
    % limit on the numbers that can be entered. Currently only checked if
    % required type = 'number'
    if ~exist('textColor','var')
        textColor = [0 0 0];
    end
    
    if ~exist('saveSlot','var') || isempty(saveSlot)
        saveSlot = 1;
    end
    
    if ~exist('textY','var')
        textY = 0;
    end
    
    if ~exist('requiredType','var')
        requiredType = false;
    end
    ShowCursor()
       
    if ~exist('trailingChar','var')
       trailingChar = ''; 
    end
    
    if ~exist('dontClear','var')
       dontClear = false; 
    end
    
    if ~exist('limit','var')
        limit = inf;
    end
      
    if dontClear
        ptb=loadWin(ptb,saveSlot);
    end
    
    if ~isempty(initText)
        [~,~,textBounds] = DrawFormattedText(ptb.win, initText, 'center', textY, textColor);
    end
    
    timeInit = Screen('Flip', ptb.win);
    newWord = true;
    textOut = '';
    while(1) % wait for user input
        if dontClear
            ptb=loadWin(ptb,saveSlot);
        end
        KbQueueFlush();
        ch = KbBlockUntilKeypress();           
        if strcmp(ch,'BackSpace') %backspace
            if ~isempty(textOut)
                textOut = textOut(1:(end-1));
                if ~isempty(textOut)
                    DrawFormattedText(ptb.win,[textOut trailingChar], 'center', textY, textColor);                    
                    Screen('Flip', ptb.win); 
                else
                    Screen('Flip', ptb.win); 
                end
            end
        elseif strcmp(ch,'ESCAPE')
            textOut = ch;
            startTypingTime=nan;
            endTypingTime=nan;
            return
        elseif (strcmp(ch,'Return') || strcmp(ch,'Enter')) %enter
            %check if they have typed enought
            if length(textOut) < requiredChars               
                if ~isempty(textOut)
                    DrawFormattedText(ptb.win, textOut, 'center','center', textColor);
                end             
                DrawFormattedText(ptb.win,'Please answer', 'center', textY, [255 0 0]);
                Screen('Flip', ptb.win); 
            else
                %save all the disp data in arrays
                endTypingTime = Screen('Flip',ptb.win);                                
                break; %break and do next test word
            end
        else
            %add char to word (if its matchs reequiredType)
            ch
            if strcmp(requiredType,'number')
                if isnan(str2double(ch))
                    continue;
                elseif limit < str2double(sprintf('%s%s',textOut,ch))
                    continue                   
                end
            end
            textOut = sprintf('%s%s',textOut,ch);
            DrawFormattedText(ptb.win,[textOut trailingChar], 'center',textY, textColor);
            timeTyping = Screen('Flip',ptb.win);
            if newWord
                startTypingTime = timeTyping;
                newWord = false;
            end
        end
    end
end