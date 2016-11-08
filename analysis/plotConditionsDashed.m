function plotConditionsDashed(linesInCond,maxLines)
    co = get(gca,'ColorOrder'); % Initial
    % Change to new colors.
    lineStyle = {'-','--',':','-.'};
    lines = flip(get(gca,'Children'));
    for i=1:maxLines
        l = mod(i-1,linesInCond)+1;
        c = floor((i-1)/linesInCond)+1;
        lines(i).Color = co(l,:);
        lines(i).LineStyle = lineStyle{c};
    end
end