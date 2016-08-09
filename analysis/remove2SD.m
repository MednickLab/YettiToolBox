function data = remove2SD(data)
%remove values (set to nan) data that is more that 2sd away
    if ~islogical(data) && ~iscell(data) && ~isstruct(data)
        SD_outlier = 2;
        threshLow = mean(data,'omitnan') - SD_outlier*std(data,'omitnan');
        threshHigh = mean(data,'omitnan') + SD_outlier*std(data,'omitnan');
        %data(isnan(data)) = threshLow-1; %%hack to stop comparison to nan;    
        data(data <= threshLow | data >= threshHigh) = nan;
    end
end