function dataOut = zscoreAcrossVariables(dataIn)
% takes a series of arrays, one for each element in the cell array *dataIn* 
% and zscores across all data across all series of arrays, then repacks into input cell aray format 
    dataOut = cell(size(dataIn));
    allData = [dataIn{:}];
    allData = nanzscore(allData);
    startIdx = 1;
    for c = 1:length(dataIn)
        lenCurrentC = length(dataIn{c});
        dataOut{c} = allData(startIdx:startIdx+lenCurrentC-1);
        startIdx = startIdx + lenCurrentC;
    end    
end