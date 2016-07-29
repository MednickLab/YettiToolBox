function myPlotlyMultiBarWeb(data,tit,leg,groupLab,xlab,ylab,pointlabel)
%     tit = 'hi';
%     xlab = 'X';
%     ylab = 'Y';
%     data = {[1 2],[3,4],[5,6],[7,8];[0 1],[2,3],[4,5],[7,8];[0 1],[2,3],[4,5],[7,8]}';
%     leg = 'hi';
%     groupLab = {'a','b','c','d'};
    traces = cell(1,size(data,1));
    
    %% do bar and error bar
    y=cellfun(@(x) mean(x,'omitnan'),data) %plot bars on mean
    err = cellfun(@(x) std(x,'omitnan')/sqrt(sum(~isnan(x))),data); %errors are std err
    for i=1:length(traces);
        traces{i} = struct(...
          'x', {groupLab(1,:)}, ...
          'y', y(i,:), ...
          'name', leg{i}, ...
          'error_y', struct(...
            'type', 'data', ...
            'array', [err(i,:),0], ...
            'visible', true), ...
          'type', 'bar');
    end
    
    layout = struct('barmode', 'group');
    response = plotly(traces, struct('layout', layout, 'filename', 'error-bar-bar', 'fileopt', 'overwrite'));
    plot_url = response.url
    
%end

%     [~,pValueWS,~,statsWS] = ttest2(cfTimeWS,cfTimeWO,'Tail','left'); %do a independent samples t test
%     [~,pValueSW,~,statsSW] = ttest2(cfTimeSW,cfTimeWO,'Tail','left'); %do a independent samples t test
%     rValueWS = (statsWS.tstat^2/(statsWS.tstat^2+statsWS.df)); %calculate effect size r
%     rValueSW = (statsSW.tstat^2/(statsSW.tstat^2+statsSW.df)); %calculate effect size r