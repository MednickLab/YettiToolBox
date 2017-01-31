function [params,paramP,ftestP,r2] = myFitLin(xPlot,yPlot)
    %Plot lin fit of x,y and plot y(t) = x*params(2) + param(1).
    goodData = ~isinf(yPlot) & ~isnan(yPlot) & ~isinf(xPlot) & ~isnan(xPlot);
    yPlot = yPlot(goodData);
    xPlot = xPlot(goodData);
    st1 = regstats(yPlot,xPlot,'linear','tstat');
    st2 = regstats(yPlot,xPlot,'linear','rsquare');
    st3 = regstats(yPlot,xPlot,'linear','fstat'); 
    params = st1.tstat.beta;
    paramP = st1.tstat.pval;
    r2 = st2.rsquare;
    ftestP = st3.fstat.pval;
    
    title(sprintf('Lin Fit (r2:%0.4f)',r2))
    hold on
    scatter(xPlot,yPlot);    
    yLine = [ones(size(xPlot)) xPlot]*st1.tstat.beta;
    plot(xPlot,yLine,'r--');
    hold off
end