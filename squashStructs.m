function s = squashStructs(s,s2)
%merges the feilds of one struct to another
    fieldNames = fieldnames(s2);
    for i = 1:size(fieldNames,1)
        s.(fieldNames{i}) = s2.(fieldNames{i});
    end   
end
