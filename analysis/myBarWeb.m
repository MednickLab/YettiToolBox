function myBarWeb(data,myTitle,myLegend,groupLabels,xLabel,yLabel,pointLabels,sigVal,colsWithin,rowsWithin)
    %Plots a nice bar graph with error bars. If data is a cell row vector
    %then the mean and stdErr of each is plotted. If data is a matrix, then
    %rows are seperate between subject groups with default 2 samples ttest (with labels in group label) and columns are
    %variables within a group (with labels in myLegend) and default paried
    %samples ttest
    if ~exist('sigVal','var') || isempty(sigVal)
        sigVal = 0.05; %defaul sig is p=0.05
    end
    
    if ~exist('colsWithin','var')  || isempty(colsWithin)
        colsWithin = true;
    end
    
    if ~exist('rowsWithin','var')  || isempty(rowsWithin)
        rowsWithin = false;
    end
     
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
            set(h(i),'Color','k')
            set(h(i),'LineStyle','none')           
        end
        yLim = ylim();
        for i=1:size(y,1)
            dataLens = cellfun(@length,data(i,:));
            if length(unique(dataLens))>1 && ~colsWithin
                [~,pVal,test] = ttestAll(data(i,:),'int',myLegend); %int ttest within groups
            else
                [~,pVal,test] = ttestAll(data(i,:),'paired',myLegend); %paired ttest within groups
            end
            for t=1:length(test)
                if pVal(t) < sigVal
                    h1 = line([x(i,test{t}(1)) mean(x(i,test{t}))],[0 yLim(1)]);
                    h2 = line([x(i,test{t}(2)) mean(x(i,test{t}))],[0 yLim(1)]);
                    if pVal(t) < sigVal/10
                        sigChar = '***';
                    elseif pVal(t) < sigVal/5
                        sigChar = '**';
                    else
                        sigChar = '*';
                    end
                    t1 = text(mean(x(i,test{t})),yLim(1)*1.1,sigChar);
                    set(t1,'Color','r');
                    set(h1,'Color',[0.7 0.7 0.7]);
                    set(h2,'Color',[0.7 0.7 0.7]);
                end
            end
        end  
        for i=1:size(y,2) %for the number of vars within group
            if rowsWithin
                [~,pVal,test] = ttestAll(data(:,i),'paired',groupLabels); %ttest across groups
            else
                [~,pVal,test] = ttestAll(data(:,i),'int',groupLabels); %ttest across groups
            end
            for t=1:length(test)
                if pVal(t) < sigVal
                    h1 = line([x(test{t}(1),i) mean(x(test{t},i))],[0 yLim(2)]);
                    h2 = line([x(test{t}(2),i) mean(x(test{t},i))],[0 yLim(2)]);
                    if pVal(t) < sigVal/10
                        sigChar = '***';
                    elseif pVal(t) < sigVal/5
                        sigChar = '**';
                    else
                        sigChar = '*';
                    end
                    t1 = text(mean(x(test{t},i)),yLim(2)*1.1,sigChar);
                    set(t1,'Color','r');
                    set(h1,'Color',[0.7 0.7 0.7]);
                    set(h2,'Color',[0.7 0.7 0.7]);
                end
            end
        end
    else
        x = 1:size(y,2);               
        ColOrd = get(gca,'ColorOrder');
        for i=x
            h = bar(i,y(i));
            set(h, 'FaceColor', ColOrd(i,:))           
        end 
        h = errorbar(y',err');
        set(h(1),'Color','k')
        set(h(1),'LineStyle','none')
        
        yLim = ylim();
        i=1;
        dataLens = cellfun(@length,data(i,:));
        if colsWithin && ~length(unique(dataLens))>1
            [~,pVal,test] = ttestAll(data(i,:),'paired',myLegend); 
        else
            [~,pVal,test] = ttestAll(data(i,:),'int',myLegend);   
        end
        for t=1:length(test)
            if pVal(t) < sigVal
                h1 = line([x(i,test{t}(1)) mean(x(i,test{t}))],[0 yLim(1)]);
                h2 = line([x(i,test{t}(2)) mean(x(i,test{t}))],[0 yLim(1)]);
                if pVal(t) < sigVal/10
                    sigChar = '***';
                elseif pVal(t) < sigVal/5
                    sigChar = '**';
                else
                    sigChar = '*';
                end
                t1 = text(mean(x(i,test{t})),yLim(1)*1.1,sigChar);
                set(t1,'Color','r');
                set(h1,'Color',[0.7 0.7 0.7]);
                set(h2,'Color',[0.7 0.7 0.7]);
            end
        end
    end
    
    
        %% add data points, p values and point labels
        for i=1:size(y,1)
           for j=1:size(y,2)
              points = data{i,j};
              if exist('pointlabel','var') && ~isempty(pointLabels)
                  for p = points
                    t = text(x(i,j)*ones(1,length(points))+0.03,p,num2str(pointLabels{i,j}));
                    for ti=1:length(t)
                        t(ti).FontSize = 6;
                    end
                  end
              end        
              scatter(x(i,j)*ones(1,length(points)),points)
           end
        end

        %% decorate
        title(myTitle)
        xlabel(xLabel)
        ylabel(yLabel)
        legend(myLegend,'Location','SouthOutside')
        set(gca,'XTick',[1:size(y,1)]) 
        set(gca,'XTickLabel',groupLabels)
        
end
