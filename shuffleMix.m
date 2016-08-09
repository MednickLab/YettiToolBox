function [shuffledArray,shuffleLocs] = shuffleMix(arrayIn,dim)
%randomly shuffles *arrayIn* along longest singlton dimention (cell or num array) or cols of array in if
%matrix. Returns shuffled array and shuffle idxs (as indexs not row/col)
    shuffleLocs = zeros(size(arrayIn));
    shuffleLocs(1:numel(shuffleLocs)) = 1:numel(shuffleLocs);
    for v = 1:size(arrayIn,dim)
        if dim==1
            vectLocs = shuffleLocs(v,:);
            shuffleLocs(v,:) = shuffle(vectLocs);
        elseif dim ==2
            vectLocs = shuffleLocs(:,v);
            shuffleLocs(:,v) = shuffle(vectLocs);
        end
    end
    shuffledArray = arrayIn(shuffleLocs);
end