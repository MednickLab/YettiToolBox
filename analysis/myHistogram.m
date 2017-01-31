function [counts,centers,edges] = myHistogram(data,nBins,xBins,myTitle,xLabel,yLabel,norm,plotly)
    if ~exist('plotly','var')
        plotly = false;
    end
    if ~exist('norm','var')
        norm = 'count';
    end
    if ~isempty(nBins)
        [counts,edges] = histcounts(data,nBins,'Normalization',norm);
        histogram(data,nBins,'Normalization',norm);
    elseif ~isempty(xBins)
        [counts,edges] = histcounts(data,xBins,'Normalization',norm);
        histogram(data,xBins,'Normalization',norm);
    else
        [counts,edges] = histcounts(data,'Normalization',norm);
        histogram(data,'Normalization',norm);
    end
    title(myTitle)
    xlabel(xLabel)
    ylabel(yLabel)
    centers = edges(1:end-1)+diff(edges)/2;
    if plotly  
        bar(centers,counts)
        title(myTitle)
        xlabel(xLabel)
        ylabel(yLabel)
        fig2plotly();
    end
end