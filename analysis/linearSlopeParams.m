%return linear fit and r2 fit stat
function [slope,inter,r2] = linearSlopeParams(x,y)
    st1 = regstats(y,x,'linear','tstat');
    slope = st1.tstat.beta(2);
    inter = st1.tstat.beta(1);
    st2 = regstats(y,x,'linear','rsquare');    
    r2 = st2.rsquare;
end