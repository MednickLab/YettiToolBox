function [params,paramP,ftestP,r2] = myFitExp(xIn,yIn)
    %Plot Log Log of x,y and fit a power law: y(x) = param(1)*e^(x*param(2)).
    xPlot = xIn;
    yPlot = log(yIn);
    [params,paramP,ftestP,r2] = myFitLin(xPlot,yPlot);
    title(sprintf('Exp Fit (r2:%0.4f)',r2))
    params(1) = exp(params(1));
    %params(2) = exp(params(2));
end