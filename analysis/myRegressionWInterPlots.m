function resid = myRegressionWInterPlots(y,X,yLab,labls,inters,plotting,omitOutliers)
    goodLocs = 1:length(y);
    resid = nan(size(y));
    notNans = ~isnan(sum([y X],2));
    y = y(notNans);
    X = X(notNans,:);
    goodLocs = goodLocs(notNans);
    reg = '';
    xMainEffect = size(X,2);
    if exist('inters','var')
    for i=1:length(inters)
        X = [X ones(size(X,1),1)];
        labls{end+1} = '';
        for j=1:length(inters{i})
            X(:,end) =  X(:,end).*X(:,inters{i}(j));
            labls{end} = [labls{end} labls{inters{i}(j)} '*'];
        end
        labls{end}(end)='';
    end
    
    end
    if omitOutliers
        st4 = regstats(y,X,'linear','cookd');
        outliers = st4.cookd>mean(st4.cookd)*3;
        y = y(~outliers);
        X = X(~outliers,:);
        goodLocs = goodLocs(~outliers);
    end
    st1 = regstats(y,X,'linear','tstat');
    st2 = regstats(y,X,'linear','adjrsquare');
    st3 = regstats(y,X,'linear','fstat');
    st4 = regstats(y,X,'linear','standres');
    resid(goodLocs) = st4.standres;
    if st3.fstat.pval < 0.01
        allsig = '> (**)';
    elseif st3.fstat.pval < 0.05
        allsig = '> (*)';
    elseif st3.fstat.pval < 0.1
        allsig = '> ms';
    else
        allsig = '';
    end
    reg = [reg sprintf('%s:  %s = ',allsig,yLab)];
    for bIdx = 2:length(st1.tstat.beta)
        if st1.tstat.pval(bIdx)<0.01
            sig = '(**)';
        elseif st1.tstat.pval(bIdx)<0.05
            sig = '(*)';
        elseif st1.tstat.pval(bIdx)<0.1
            sig = '(ms)';
        else
            sig = '';
        end
        reg = [reg sprintf('%0.5f*%s%s\n                + ',st1.tstat.beta(bIdx),labls{bIdx-1},sig)];
    end
    if st1.tstat.pval(1)<0.01
       sig = '(**)';
    elseif st1.tstat.pval(1)<0.05
        sig = '(*)';
    elseif st1.tstat.pval(1)<0.1
       sig = '(ms)';
    else
       sig='';
    end
    reg = [reg sprintf('%0.5f%s\n\n-----R2(adj)=%0.2f, p=%0.12f, df=%i-------\n\n',st1.tstat.beta(1),sig,st2.adjrsquare,st3.fstat.pval,st1.tstat.dfe)];     
    if plotting
        figure('Position',[100,100,800,800])
        for i=1:xMainEffect 
            subplot(1+logical(length(inters)),xMainEffect,i)
            myCorrScatter(y,X(:,i),['Cor ' yLab ' and ' labls{i}],yLab,labls{i},false)
        end
        for j=1:length(inters)
            if length(inters{j})>2
                return; %cannot hanndle 3 way interactions...
            end
            subplot(1+logical(length(inters)),xMainEffect,j+i)
            myInteractionPlotter(y,X(:,inters{j}),yLab,labls(inters{j}));
        end
    subplot(2,2,4)
    text(0.1,0.5,reg);
    else
        disp(reg)
    end
end