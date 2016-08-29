function [counts,xBins] = myAreaPlot(xIn,yIn,nBins,xBins,myTitle,xLabel,yLabel,norm,plotly)
    if ~exist('plotly','var')
        plotly = false;
    end
    if ~exist('norm','var')
        norm = false;
    end
    if ~isempty(nBins)
        xBins = linspace(min(cellfun(@min,xIn)),max(cellfun(@max,xIn)),nBins+1); %bins for all
    else %max bins
        xBins = linspace(min(cellfun(@min,xIn)),max(cellfun(@max,xIn)),size(xIn,2)+1);
    end
    for i=1:length(yIn)
        [xSorted,sortIdx] = sort(xIn{i});
        ySorted  = yIn{i}(sortIdx);
        xBins(end) = xBins(end)+0.00000000001; %because histC is stupid and doesnt do <=, just <
        [~, idx] = histc(xSorted,xBins);
        counts(i,:) = accumarray(idx',ySorted)';
    end
    if norm
        data = (counts./repmat(sum(counts,1),size(counts,1),1))';
    else
        data = counts';
    end
    area(xBins,[data ; data(1,:)])
    title(myTitle)
    xlabel(xLabel)
    ylabel(yLabel)
    if plotly
        fig2plotly(gcf,myTitle,'matlab-basic-area','fileopt','overwrite')
    end
end