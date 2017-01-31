function parts = splitArray(arrayToSplit,splitNum,arrayToMatch)
    if ~exist('arrayToMatch','var')
        splitLocs = find(arrayToSplit==splitNum);
    else
        splitLocs = find(arrayToMatch==splitNum);
    end
    parts = cell(size(splitLocs));
    for s = 2:length(splitLocs)
        parts{s-1} = arrayToSplit(splitLocs(s-1):splitLocs(s)-1);
    end
    parts{s} = arrayToSplit(splitLocs(s):end);
end