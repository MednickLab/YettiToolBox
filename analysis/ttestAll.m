function [h,pVal,test,testText] = ttestAll(dataIn,type,varNames)
    %tests all possible ttests between the variables in *dataIn*. dataIn should be a cell array of arrays containing individual datapoints
    % Can be 'paired' or 'independent' based on *type*
    if length(dataIn) > 1
        pairs = nchoosek(1:length(dataIn),2);
        h = nan(size(pairs,1),1);
        pVal = nan(size(pairs,1),1);
        test = cell(size(pairs,1),1);
        testText = cell(size(pairs,1),1);
        for p=1:size(pairs,1)
            if strcmp(type,'paired')
                [h(p),pVal(p)] = ttest(dataIn{pairs(p,1)},dataIn{pairs(p,2)});
            else
                [h(p),pVal(p)] = ttest2(dataIn{pairs(p,1)},dataIn{pairs(p,2)});
            end
            test{p} = pairs(p,:);
            testText{p} = sprintf('%s vs %s',varNames{pairs(p,1)},varNames{pairs(p,2)});
        end
    else
        h=[];
        pVal=[];
        test=[];
        testText=[];
    end
end