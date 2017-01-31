function s = myTable2Struct(t)
    fNames = fieldnames(t);
    fNames = fNames(~strcmp(fNames,'Properties'));
    for i=1:length(fNames)
        s.(fNames{i}) = t.(fNames{i});
    end
end