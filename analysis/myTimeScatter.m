function myTimeScatter(data,tit,leg,xlab,ylab)    
    figure 
    hold on
    %% do bar and error bar
    ColOrd = get(gca,'ColorOrder');
    realLeg = {};
    fullX = cell(size(data));
    fullY = cell(size(data));
    for i=1:length(data)
        fullX{i} = [];
        fullY{i} = [];
        for j=1:length(data{i})
            x = 1:length(data{i}{j});
            %x = x(~isnan(data{i}{j}));
            y = data{i}{j};%(~isnan(data{i}{j}));
            y = nanzscore(y);  
            fullX{i} = [fullX{i} x];
            fullY{i} = [fullY{i} y];
        end
        fullXNoNan{i} = fullX{i}(~isnan(fullY{i}))';
        fullYNoNan{i} = fullY{i}(~isnan(fullY{i}));
        s = scatter(fullXNoNan{i},fullYNoNan{i});
        realLeg{i*2-1}=leg{i};
        s.MarkerEdgeColor = ColOrd(i,:);
        coeffs = polyfit(fullXNoNan{i},fullYNoNan{i},1); %find line coeffes
        fittedX = linspace(min(fullXNoNan{i}), max(fullXNoNan{i}), 200); % create x vals for line of best fit
        fittedY = polyval(coeffs, fittedX); % create y vals for line of best fit
        plot(fittedX, fittedY,'LineWidth', 1,'Color',ColOrd(i,:)); %plot line of best fit
        [b,~,~,~,stats] = regress(fullYNoNan{i},[ones(size(fullXNoNan{i})) fullXNoNan{i}]); %find line coeffes
        realLeg{i*2}=[leg{i} sprintf(' = %0.3f*time + %0.2f (R2=%2f, p=%0.7f)',b(2),b(1),stats(1),stats(3))];
    end
    if length(data)==2
        fullY1 = fullY{1}(~isnan(fullY{1}) & ~isnan(fullY{2}));
        fullY2 = fullY{2}(~isnan(fullY{1}) & ~isnan(fullY{2}));
        [r,p] = corrcoef(fullY1,fullY2);
        cor = sprintf('r=%0.4f, p=%0.7f\n',r(2,1),p(2,1));
        text(1,-2.5,cor);
    end
     
    %% decorate
    title(tit)
    xlabel(xlab)
    ylabel(ylab)
    legend(realLeg)  
    hold off
end

%     [~,pValueWS,~,statsWS] = ttest2(cfTimeWS,cfTimeWO,'Tail','left'); %do a independent samples t test
%     [~,pValueSW,~,statsSW] = ttest2(cfTimeSW,cfTimeWO,'Tail','left'); %do a independent samples t test
%     rValueWS = (statsWS.tstat^2/(statsWS.tstat^2+statsWS.df)); %calculate effect size r
%     rValueSW = (statsSW.tstat^2/(statsSW.tstat^2+statsSW.df)); %calculate effect size r