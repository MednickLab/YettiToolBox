function data = removeXSD(data,sdLevel)
%remove values (set to nan) data that is more that 2sd away
    if ~islogical(data) && ~iscell(data) && ~isstruct(data)
        SD_outlier = sdLevel;
        threshLow = mean(data,'omitnan') - SD_outlier*std(data,'omitnan');
        threshHigh = mean(data,'omitnan') + SD_outlier*std(data,'omitnan');  
        data(data <= threshLow | data >= threshHigh) = nan;
    end
end