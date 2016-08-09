function [A,B] = splitVec(vec,loc)
    if loc
    A = vec(1:loc);
    B = vec(loc+1:end);
    else
    A = cell(0);
    B = vec;
    end
end