function myInteractionPlotter(y,X,ylab,labls)
    %find dummy vars, or something easy to vary...
    ranks = zeros(size(X,2));
    inters = 1:size(X,2);
    ranks = zeros(1,size(X,2));
    for i=1:2
        ranks(i) = length(unique(X(:,i)));
    end
    [minVal,minLoc] = min(ranks);     
    lowestRank = minLoc; %ok so use this one to vary
    ranks(minLoc)=0;
    [maxVal,maxLoc] = max(ranks);
    highestRank = maxLoc;
    if minVal==2;
        dicotomizedX = X(:,lowestRank);
        if any(dicotomizedX==-1) %if effects coded, sort it out....
            dicotomizedX(dicotomizedX==-1) = 0;
        end
    else
        median(X(:,lowestRank),'omitnan');
        [sortedX,sortIdx] = sort(X(:,lowestRank));
        half = round(length(sortedX)/2);
        sortedX(1:half) = 0;
        sortedX(half+1:end) = 1;
        dicotomizedX = logical(sortedX(sortIdx));
    end
    hold on
    leg = cell(4,1);
    level = {'high','low'};
    color = {'r','b'};
    for i=0:1
        data1In = y(logical(abs(dicotomizedX-i)));
        data2In = X(logical(abs(dicotomizedX-i)),highestRank);
        data1=data1In(~isnan(data1In) & ~isnan(data2In));
        data2=data2In(~isnan(data1In) & ~isnan(data2In));
        h1 = scatter(data2,data1,color{i+1});
        h2 = lsline;
        h2(1).Color = color{i+1};
        [cor,ps] = corrcoef(data1,data2);
        leg{2*i+1}=sprintf('%s=%s',labls{lowestRank},level{i+1});
        leg{2*i+2}=sprintf('r=%2f, p=%0.7f)',cor(2,1),ps(2,1));
    end
    hold off
    
    title(['Corr ' ylab ' and ' labls{highestRank} ' @ ' labls{lowestRank}])
    xlabel(labls{highestRank});
    ylabel(ylab)
    legend(leg,'Location','SouthOutside')
    
end
