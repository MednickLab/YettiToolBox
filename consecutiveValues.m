function dataOut = consecutiveValues(vectorIn)
    %finds consecutive values in a vector. Returns a cell array with a struct for each element with the
    %following feilds:
    % vals: identiy of each consecutive value chunk
    % lengthSeqs: length of consecutive value chunk
    % startSeqs: Start of the consecutive value chunk
    % endSeqs: end of the consecytive value chunks
    % Does not currently handle NaN data, replace NaN with something else
    % (some interger)before inputing into function
    allChanges = [1 (diff(vectorIn)~=0)];
    posChanges = find(allChanges);
    subData.vals = vectorIn(posChanges);
    subData.lengthSeqs = diff([posChanges length(vectorIn)+1]);  
    subData.startSeqs = posChanges;
    subData.endSeqs = [posChanges(2:end)-1 length(vectorIn)];
    dataOut = subData;
end