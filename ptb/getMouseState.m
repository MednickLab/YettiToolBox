function [ptb] = getMouseState(ptb)
%gets the state and postion of all buttons on the mouse (based on incoming
%current mouse state. Right mouse does not return drag, just click, no
%click only
%run this function inside a while loop!
    %mouse states
    MOUSE_INIT = -1;
    MOUSE_OFF = 0;
    MOUSE_CLICKED = 1;
    MOUSE_RELEASED = 2;
    MOUSE_DRAG = 3;
    
    DRAG_TIME = 0.05;
    
    if ptb.mouseState == MOUSE_INIT %have to give an initial tic for the toc
        ptb.dragInitTime = GetSecs();
    end

    if ptb.mouseState == MOUSE_RELEASED %reset mouse back to zero after one loop of release
        ptb.mouseState = MOUSE_OFF;
    end
    
    [ptb.x,ptb.y,buttons]=GetMouse(ptb.win);  %waits for a key-press
    
%     if buttons(3) && ptb.rightMouse==MOUSE_OFF %we have click, and have processed outside of this function
%         ptb.rightMouse = MOUSE_CLICKED;
%     else
%         if ptb.rightMouse==MOUSE_CLICKED && ~buttons(3)
%             ptb.rightMouse=MOUSE_RELEASED;
%         elseif ptb.rightMouse==MOUSE_RELEASED
%             ptb.rightMouse=MOUSE_OFF;
%         end
%     end

    %check 4 press
    if buttons(1)
        if ~((ptb.mouseState==MOUSE_DRAG) || (ptb.mouseState==MOUSE_CLICKED))
            ptb.mouseState = MOUSE_CLICKED; %if mouse not already clicked then make it so
            ptb.dragInitTime = GetSecs(); %start drag timer
        end
    else %if no buttons are pressed
        if ptb.mouseState == MOUSE_RELEASED %if the mouse state was released, and is not pressed then...
            ptb.mouseState = MOUSE_OFF; %then set mouse state to off
        elseif ptb.mouseState==MOUSE_CLICKED || ptb.mouseState==MOUSE_DRAG %If the mouse state was clicked or drag, and currently there is no mouse then set release
            ptb.mouseState = MOUSE_RELEASED;
        end
    end
    if GetSecs()-ptb.dragInitTime > DRAG_TIME %buttons stil pressed after debounce time so we have a drag    
        [ptb.x,ptb.y,buttons]=GetMouse(ptb.win);  %waits for a key-press
        if ((ptb.mouseState == MOUSE_CLICKED) && buttons(1)) %if the mouse state was clicked and is still clicked
            ptb.mouseState=MOUSE_DRAG; %then we are dragging
        end
    end
    %disp(ptb.mouseState)
end