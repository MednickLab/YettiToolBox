function dataOut = consecutiveValuesInv(consecData)
    %Takes data in the form a cell array with a struct for each element with the
    %following feilds:
    % vals: identiy of each consecutive value chunk
    % lengthSeqs: length of consecutive value chunk
    % And reformats into repeating values. Essentually undoes what
    % consecutiveValues did
    dataOut = sum(consecData.lengthSeqs);
    for seq = 1:length(consecData.vals)
        sIdx = sum(consecData.lengthSeqs(1:seq-1))+1;
        eIdx = sum(consecData.lengthSeqs(1:seq));
        dataOut(sIdx:eIdx) = repmat(consecData.vals(seq),1,consecData.lengthSeqs(seq));
    end   
end