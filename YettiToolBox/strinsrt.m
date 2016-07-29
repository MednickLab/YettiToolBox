function strOut = strinsrt(str,loc,substr)
%Inserts substr into another str at location loc
    A = str(1:loc);
    B = str(loc+1:end);
    strOut = [A substr B];
end