function resid = myRegression(y,X,yLab,labls,omitOutliers)
    goodLocs = 1:length(y);
    resid = nan(size(y));
    notNans = ~isnan(sum([y X],2));
    y = y(notNans);
    X = X(notNans,:);
    goodLocs = goodLocs(notNans);
    if exist('omitOutliers','var') && omitOutliers
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
    fprintf('%s:  %s = ',allsig,yLab)
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
        fprintf('%0.5f*%s%s + ',st1.tstat.beta(bIdx),labls{bIdx-1},sig);
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
    fprintf('%0.5f%s\nR2(adj)=%0.2f, p=%0.12f, df=%i\n\n',st1.tstat.beta(1),sig,st2.adjrsquare,st3.fstat.pval,st1.tstat.dfe);
    
end