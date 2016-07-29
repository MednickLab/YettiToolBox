function stacked = halfStack(arrayIn)
    %takes a row vector as an input, splits it in half and stacks it to
    %create a 2 row vector of half the length
    halfArray = length(arrayIn)/2;
    stacked = [arrayIn(1:halfArray) ; arrayIn(halfArray+1:end)];
end