function myVar = defaultIfMissing(varName,myVar,default)
    if ~exist(varName,'var') || isempty(myVar)
        myVar = default;
    end
end