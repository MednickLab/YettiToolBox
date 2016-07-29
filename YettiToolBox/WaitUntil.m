function WaitUntil(time)
% Wait until GetSecs = time
while (GetSecs < time) 
    WaitSecs(0.005);
end
