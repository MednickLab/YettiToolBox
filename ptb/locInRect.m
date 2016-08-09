function inRect = locInRect(x,y,rect)
%returns true if *x* and *y* location is in *rect*
    if x < rect(3) && x > rect(1) && y > rect(2) && y < rect(4)
        inRect = true;    
    else
        inRect = false; 
    end
end