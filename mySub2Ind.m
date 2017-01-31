function idx  =mySub2Ind(sz,idxPairs)
%a much faster version of sub2ind, where idxPairs is  [x1 y1; x2 y2]
    idx = idxPairs*[1; sz(1)] - sz(1);
end