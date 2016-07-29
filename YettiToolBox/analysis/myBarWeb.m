function myBarWeb(data,tit,leg,groupLab,xlab,ylab,pointlabel)
%     tit = 'hi';
%     xlab = 'X';
%     ylab = 'Y';
%     data = {[1 2],[3,4],[5,6],[7,8];[0 1],[2,3],[4,5],[7,8];[0 1],[2,3],[4,5],[7,8]}';
%     leg = 'hi';
%     groupLab = {'a','b','c','d'};
    
    figure 
    hold on
    %% do bar and error bar
    y=cellfun(@(x) mean(x,'omitnan'),data); %plot bars on mean
    [~,ps] = cellfun(@ttest,data);
    err = cellfun(@(x) std(x,'omitnan'),data); %errors are std dev      
    if size(y,1)>1
        bar(y)
        x = repmat((1:size(y,1)),size(y,2),1);
        for i=1:size(y,1)
            x(:,i) = x(:,i) + linspace(-size(y,2)*0.075,size(y,2)*0.075,size(y,2))';
        end
        x = x';
        h = errorbar(x,y,err,'-');
        for i=1:size(y,2)
            set(h(i),'color','k')
            set(h(i),'LineStyle','none')
        end
    else
        x = 1:size(y,2);
        ColOrd = get(gca,'ColorOrder');
        for i=x
            h = bar(i,y(i));
            set(h, 'FaceColor', ColOrd(i,:))           
        end 
        h = errorbar(y',err');
        set(h(1),'color','k')
        set(h(1),'LineStyle','none')
    end
    
    
        %% add data points, p values and point labels
        for i=1:size(y,1)
           for j=1:size(y,2)
              points = data{i,j};
              if exist('pointlabel')
                  for p = points
                    t = text(x(i,j)*ones(1,length(points))+0.03,p,num2str(pointlabel{i,j}));
                    for ti=1:length(t)
                        t(ti).FontSize = 6;
                    end
                  end
              end        
              scatter(x(i,j)*ones(1,length(points)),points)
           end
        end

        %% decorate
        title(tit)
        xlabel(xlab)
        ylabel(ylab)
        legend(leg,'Location','SouthOutside')
        set(gca,'XTick',[1:size(y,1)]) 
        set(gca,'XTickLabel',groupLab)
%end

%     [~,pValueWS,~,statsWS] = ttest2(cfTimeWS,cfTimeWO,'Tail','left'); %do a independent samples t test
%     [~,pValueSW,~,statsSW] = ttest2(cfTimeSW,cfTimeWO,'Tail','left'); %do a independent samples t test
%     rValueWS = (statsWS.tstat^2/(statsWS.tstat^2+statsWS.df)); %calculate effect size r
%     rValueSW = (statsSW.tstat^2/(statsSW.tstat^2+statsSW.df)); %calculate effect size r