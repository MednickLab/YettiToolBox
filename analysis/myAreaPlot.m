function [data] = myAreaPlot(xIn,yIn,nBins,xBins,myTitle,xLabel,yLabel,norm,plotly)
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
        [~, idx] = histc(xSorted,xBins);
        data(i,:) = accumarray(idx',ySorted)';
    end

    if norm
        data = data./repmat(sum(data,1),size(data,1),1);
    end
    area(xBins,data')
%     title(myTitle)
%     xlabel(xLabel)
%     ylabel(yLabel)
%     if plotly
%         fig2plotly('filename',title,'fileopt','overwrite')
%     end
end