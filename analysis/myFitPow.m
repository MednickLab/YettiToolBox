function [params,paramP,ftestP,r2] = myFitPow(xIn,yIn)
    %Plot Log Log of x,y and fit a power law: y(x) = param(1)*x^param(2).
    %log both sides
    xPlot = log(xIn);
    yPlot = log(yIn);
    %gives log(y) = log(param(2)) + param(1)*log(x)
    [params,paramP,ftestP,r2] = myFitLin(xPlot,yPlot);
    title(sprintf('Power Fit (r2:%0.4f)',r2))
    params(1) = exp(params(1));
end