function [shuffledArray, shuffleIndex] = shuffle(arrayIn)
%randomly shuffles *arrayIn* along longest singlton dimention (cell or num array) or cols of array in if
%matrix. Returns shuffled array and shuffle idxs
    [rows,cols] = size(arrayIn);
        shuffleIndex = randperm(length(arrayIn));
    if rows > cols
        shuffledArray = arrayIn(shuffleIndex,:);
    else
        shuffledArray = arrayIn(:,shuffleIndex);
    end
end