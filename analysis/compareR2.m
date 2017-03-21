function [p,F] = compareR2(r21,r22,k1,k2,n)
    %k2 > k1 (k2 is the better morel)
    F = ((r22-r21)/(k2-k1))/((1-r22)/(n-k2-1));
    p = 1-fcdf(F,k2-k1,n-k2-1);
end