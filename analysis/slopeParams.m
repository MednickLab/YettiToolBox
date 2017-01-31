%Find slope and intercept of multi-level data
function [slope,inter] = slopeParams(data,colorChange) %TODO plotting....
    colors = {'r','b','k','c','m'};
    slope = nan(size(data));
    inter = nan(size(data));
    hold on
    for i=1:length(data)
        y = data{i};
        if sum(~isnan(y))<=4; continue; end;
        x = find(~isnan(y));
        y = y(~isnan(y));
        st1 = regstats(y,x,'linear','tstat');
        slope(i) = st1.tstat.beta(2);
        inter(i) = st1.tstat.beta(1);
        scatter(x,y,colors{colorChange(i)});
        h2 = lsline;
        h2(1).Color = colors{colorChange(i)};
    end
    hold off
end