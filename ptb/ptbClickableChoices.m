function [choice, choiceText, dispTime, clickTime, exit, ny] = ptbClickableChoices(ptb,answrs,textY,dir,dontClear,saveSlot,drawOnly,buttonColor)
    dispTime = nan;
    exit = false;
    if ~exist('textY','var') || isempty(textY)
        textY = 0;
    end
      
    if ~exist('dontClear','var') || isempty(dontClear)
       dontClear = false; 
    end
    
    if ~exist('saveSlot','var') || isempty(saveSlot)
       saveSlot = 1; 
    end
    
    if ~exist('drawOnly','var') || isempty(drawOnly)
        drawOnly = false;
    end
    
    if ~exist('buttonColor','var') || isempty(buttonColor)
        buttonColor = [200 200 200];
    end
          
    oldTextSize = Screen(ptb.win,'TextSize',ptb.buttonTextSize);
    if ~strcmp(dir,'vert')
        totalButtonLen = ptb.xRes-100;
        buttonSizeY = 50;
        padding = 10;
        buttonSizeX = (totalButtonLen+padding)/length(answrs)-padding;
        buttonXstart = ptb.cx-totalButtonLen/2;
        buttonLocs = cell(size(answrs));
        buttonTextX = zeros(size(answrs));
        buttonTextY = zeros(size(answrs));
        for a = 1:length(answrs)
            [answrs{a},~,textBounds] = formatBoundedText(ptb,buttonSizeX-10,buttonSizeY,answrs{a}); %10 for a bit of padding
            x1 = buttonXstart+(buttonSizeX+padding)*(a-1);
            x2 = x1+buttonSizeX;
            y1 = textY;
            textH = textBounds(4)-textBounds(2)+10;
            textW = textBounds(3)-textBounds(1)+10;
            if textH < buttonSizeY
                y2 = y1+buttonSizeY; %minimum Y at buttonSizeY
            else
                y2 = y1+textH; 
            end
            buttonLocs{a} = [x1 y1 x2 y2];
            rectOut = centerRectInRect(buttonLocs{a},textBounds); %to draw text in the middle of button, we need to know where to start it
            buttonTextX(a) = rectOut(1);
            buttonTextY(a) = rectOut(2)-10/2;
            if textH > buttonSizeY
                buttonTextY(a) = buttonLocs{a}(2)+1;
            end

            if textW > buttonSizeX
                buttonTextX(a) = buttonLocs{a}(1)+1;
            end
        end
    else
        [~,largestLen] = sort(cellfun(@length,answrs));
        largestLen = largestLen(end);
        [~,~,tBounds] = DrawFormattedText(ptb.win,answrs{largestLen},'center','center');
        buttonSizeX = min([tBounds(3)-tBounds(1)+20 ptb.xRes-200]); %what ever is smaller
        totalButtonLen = ptb.yRes-textY-100;
        padding = 10;
        if length(answrs) == 1
            buttonSizeY = tBounds(4) - tBounds(2)+padding*3;
        else
            buttonSizeY = (totalButtonLen+padding)/length(answrs)-padding;  
        end
        buttonYstart = textY;
        buttonLocs = cell(size(answrs));
        buttonTextX = zeros(size(answrs));
        buttonTextY = zeros(size(answrs));
        for a = 1:length(answrs)
            [answrs{a},~,textBounds] = formatBoundedText(ptb,buttonSizeX,buttonSizeY,answrs{a}); %10 for a bit of padding
            x1 = ptb.cx-buttonSizeX/2;
            x2 = ptb.cx+buttonSizeX/2;
            y1 = buttonYstart+(buttonSizeY+padding)*(a-1);
            y2 = y1+buttonSizeY;
            buttonLocs{a} = [x1 y1 x2 y2];
            rectOut = centerRectInRect(buttonLocs{a},textBounds); %to draw text in the middle of button, we need to know where to start it
            buttonTextX(a) = rectOut(1);
            buttonTextY(a) = rectOut(2)-10/2;
        end
    end
        
    ShowCursor();
    dispTime = GetSecs();%Screen('Flip', ptb.win);
    while(1) % wait for user input
        if dontClear
            ptb=loadWin(ptb,saveSlot); %load whatever was on screen
        end
        for choice = 1:length(answrs)
            choiceText = answrs{choice};
            [clicked,clickTime] = drawButton(ptb,buttonLocs{choice},choiceText,'FillRect',round(buttonTextX(choice)),round(buttonTextY(choice)),buttonColor);
            if clicked
                break;
            end
        end
        if clicked
            break
        end
        if ~drawOnly
            Screen('Flip', ptb.win); %draw loop   
        else
            break %*drawOnly* just draw's it once (without flip), then breaks. These buttons will be static...
        end
        ptb=getMouseState(ptb);
        if strcmp(getLastKey(),'ESCAPE'); exit = true; break; end;
    end
    ny = buttonLocs{end}(4);
    Screen(ptb.win,'TextSize',oldTextSize);