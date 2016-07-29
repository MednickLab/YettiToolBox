function addLabeledLines(locs,color,style,label)
for i=1:length(locs)    
    % Add lines
    ys = ylim;    
    h1 = line([locs(i) locs(i)],ys);
    set(h1,'LineStyle',style,'Color',color,'LineWidth',1)
    h = text(locs(i),ys(2)-0.2,label,'HorizontalAlignment','center');
    set(h, 'rotation', 60)
end
