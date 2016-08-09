function [params,paramP,ftestP,r2] = myFitStrechedExp(xIn,yIn)
    %Plot LogLog-Log of x,y and fit a power law: y(t) = param(1)*e^-(x*param(2))^param(2)
    xPlot = log(xIn);
    yPlot = log(log(yIn));
    [params,paramP,ftestP,r2] = myFitLin(xPlot,yPlot);
    title(sprintf('Streched Exp Fit (r2:%0.4f)',r2))
    params(1) = exp(exp(params(1)));
end