function structData = structRowsToCols(structData)
fnames = fieldnames(structData);
for i=1:length(fnames)
    sizeData = size(structData.(fnames{i}));
    if sizeData(1) < sizeData(2)
        structData.(fnames{i}) = structData.(fnames{i})';
    end
end