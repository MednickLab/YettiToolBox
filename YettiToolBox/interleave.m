function out = interleave(a,b)
    sizeA = size(a);
    if sizeA(1) < sizeA(2) %row vect
       a = a';
       b = b';
    end
    if iscell(a)
        out = cell(size(a,1)+size(b,1),size(a,2));
    else
        out = nan(size(a,1)+size(b,1),size(a,2));
    end
    for col = 1:size(a,2)
        out(:,col) = Interleave(a(:,col),b(:,col));       
    end
    if sizeA(1) < size(2) %col vect
       out = out';
    end
end