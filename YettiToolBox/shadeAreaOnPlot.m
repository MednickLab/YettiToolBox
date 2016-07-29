function shadeAreaOnPlot(starts,ends,color,label,after)
if length(starts)~=length(ends)
    warning('The amount of ends to not match the number of starts, starts/ends have been truncated to match');
end
starts=starts(1:min([length(ends) length(starts)]));
ends=ends(1:min([length(ends) length(starts)]));
for i=1:length(starts)
    
    % Add lines
    ys = ylim;
    h = text(mean([starts(i) ends(i)]),ys(2)-0.1,label,'HorizontalAlignment','center');
    set(h, 'rotation', 60)
    h1 = line([starts(i) starts(i)],ys);
    h2 = line([ends(i) ends(i)],ys);

    %color line
    set([h1 h2],'Color',color+0.05,'LineWidth',1)
    % Add a patch
    patch([starts(i) ends(i) ends(i) starts(i)],[ys(1) ys(1) ys(2) ys(2)],color)
end
% The order of the "children" of the plot determines which one appears on top.
if exist('after','var')
    if after
        set(gca,'children',flipud(get(gca,'children'))) 
    end
end