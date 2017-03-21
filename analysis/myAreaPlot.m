function [counts,xBins,n] = myAreaPlot(xIn,yIn,nBins,xBins,myTitle,xLabel,yLabel,norm,plotly)
    %Plots an area plot. xIn and yIn should be a cell arrays, with one element for each catagory of the plotted data (e.g. for sleep, 5 catergories, 1 for each sleep stage).
    %Each element in xIn should be an array of x values corrisponding to y values (in yIn).
    %Y valus can be in counts or percentages. nBins are how many bins along the x axis to slice the
    %x data into. exact edges for these bins can also be used (xBins - nBin should be empty [] in
    %this case).
    % Data can be plotted raw (norm=false), normlaized by norm="probability" (i.e. each bin sums to
    % one), or norm="perBin" where the counts are normed (averaged) per bin (but may not sum to
    % one).
    if ~exist('plotly','var')
        plotly = false;
    end
    if ~exist('norm','var')
        norm = false;
    end
    if ~isempty(nBins)
        xBins = linspace(min(cellfun(@min,xIn)),max(cellfun(@max,xIn)),nBins+1); %bins for all
        nBins = length(xBins)-1;
    elseif isempty(xBins) %max bins
        xBins = linspace(min(cellfun(@min,xIn)),max(cellfun(@max,xIn)),size(xIn,2)+1); 
        nBins = length(xBins)-1;
    end
    counts = zeros(length(xIn),nBins);
    for i=1:length(yIn)
        [xSorted,sortIdx] = sort(xIn{i});
        ySorted  = yIn{i}(sortIdx);
        xBins(end) = xBins(end)+0.00000000001; %because histC is stupid and doesnt do <=, just <
        [n{i}, idx] = histc(xSorted,xBins);
        accumOut = accumarray(idx',ySorted)';
        counts(i,1:length(accumOut)) = accumOut;
    end
    n = sum(vertcat(n{:}),1)/length(yIn);
    n = n(1:max(idx));
    if strcmp(norm,'probability')
        data = (counts./repmat(sum(counts,1),size(counts,1),1))';
    elseif strcmp(norm,'perBin')
        data = (counts./n)';
    else
        data = counts';
    end
    area(xBins(1:end-1)+diff(xBins)/2,data) 
    %area(xBins,[data ; data(1,:)]) %If you want wrapping (i.e. circular space) then uncomment this
    title(myTitle)
    xlabel(xLabel)
    ylabel(yLabel)
    if plotly
        fig2plotly(gcf,myTitle,'matlab-basic-area','fileopt','overwrite')
    end
end