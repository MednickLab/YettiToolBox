function plotConditionsDashed(linesInCond,maxLines,currentAxes,colormap)
    if ~exist('currentAxes','var') || isempty(currentAxes);
        currentAxes = gca;      
    end
    if exist('colormap','var')
        co = colormap;
    else
        co = get(currentAxes,'ColorOrder'); % Initial
    end
    % Change to new colors.
    lineStyle = {'-','--',':','-.'};
    lines = flip(get(currentAxes,'Children'));
    for i=1:maxLines
        l = mod(i-1,linesInCond)+1;
        c = floor((i-1)/linesInCond)+1;
        lines(i).Color = co(l,:);
        lines(i).LineStyle = lineStyle{c};
    end
end