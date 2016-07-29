function logicalSplit = medianSplit(var2Split)
%%returns a logical array (*logicalSplit*) where 1 is the high and 0 is the low median split
%%on the *var2Split*
    medianVal = median(var2Split,'omitnan');
    logicalSplit = var2Split>medianVal;
end