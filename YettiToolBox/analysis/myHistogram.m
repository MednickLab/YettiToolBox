function myHistogram(data,m,bins,myTitle,xLabel,yLabel,plotly)
    if ~exist('plotly','var')
        plotly = false;
    end
    if ~isempty(m)
        histogram(data,m)
    elseif ~isempty(bins)
        histogram(data,bins)
    else
        histogram(data)
    end
    title(myTitle)
    xlabel(xLabel)
    ylabel(yLabel)
    if plotly
        fig2plotly('filename',title,'fileopt','overwrite')
    end
end