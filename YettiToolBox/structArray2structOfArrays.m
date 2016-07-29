function structArray2structOfArrays(structArray)
    %convert a 'structArray' i.e. p(1).a =1 , p(2).a=2 to sturct of arrays
    %p.a(1) = 1, p.a(2) = 2
    fnames = fieldnames(structArray(1));
    a = squeeze(struct2cell(structArray));
    b = cell2mat(a)';
    c = mat2cell(b,size(b,1),ones(1,size(b,2)));
    cell2struct(c',fnames)
end