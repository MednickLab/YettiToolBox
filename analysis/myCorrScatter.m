function myCorrScatter(data1In,data2In,tit,ylab,xlab,omitOutliers) 
    if exist('omitOutliers','var') && omitOutliers
        st4 = regstats(data1In,data2In,'linear','cookd');
        outliers = st4.cookd>mean(st4.cookd)*3;
        data1In = data1In(~outliers);
        data2In = data2In(~outliers); 
    end
    hold on
    data1=data1In(~isnan(data1In) & ~isnan(data2In));
    data2=data2In(~isnan(data1In) & ~isnan(data2In));
    h = scatter(data2,data1);
    [cor,ps] = corrcoef(double(data1),double(data2));
    lne = lsline;
    set(lne(1),'color',h.CData)
    leg=sprintf('r=%2f, p=%0.7f)',cor(2,1),ps(2,1));
    title(tit)
    xlabel(xlab)
    ylabel(ylab)
    legend(leg,'Location','NorthOutside')  
    hold off
end