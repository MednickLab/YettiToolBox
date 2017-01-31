function [logicalSplitHigh,logicalSplitLow] = medianSplit(var2Split)
%%returns a logical array (*logicalSplitHigh*) where 1 is the high and 0 is
%%the low median split AND any NaN's
%%If you do not want NaN's to appear as 0s in LogicalSplitHigh, then use
%%both logicalSplitHigh (1 when above median) and logicalSplitLow (1 when below median)
    medianVal = median(var2Split,'omitnan');
    logicalSplitHigh = var2Split>=medianVal;
    logicalSplitLow = var2Split<=medianVal;
end