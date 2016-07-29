function dataOut = consecutiveValues(data)
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