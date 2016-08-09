function dataOut = consecutiveValues(data)
    %finds consecutive values in a vector (or group of vectors stacked as a
    %matrix). Returns a cell array with a struct for each vector with the
    %following information:
    % vals: identiy of each consecutive value chunk
    % lengthSeq: length of consecutive value chunk
    % startSeq: Start of the consecutive value chunk
    % endSeqs: end of the consecytive value chunks
    % Does not currently handle NaN data, replace NaN with something else
    % (some interger)before inputing into function
    dataOut = cell(size(data,1),1);
    for row = 1:size(data,1)
        subVec = data(row,:);
        allChanges = [1 (diff(subVec)~=0)];
        posChanges = find(allChanges);
        subData.vals = subVec(posChanges);
        subData.lengthSeqs = diff([posChanges length(subVec)+1]);  
        subData.startSeqs = posChanges;
        subData.endSeqs = [posChanges(2:end)-1 length(subVec)];
        dataOut{row} = subData;
    end   
end