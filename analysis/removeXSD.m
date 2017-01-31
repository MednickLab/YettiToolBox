function [data,removeIdx] = removeXSD(data,outlierXSD)
%remove values (set to nan) data that is more that 2sd away
    if ~islogical(data) && ~iscell(data) && ~isstruct(data)
        threshLow = mean(data,'omitnan') - outlierXSD*std(data,'omitnan');
        threshHigh = mean(data,'omitnan') + outlierXSD*std(data,'omitnan');
        removeIdx = data <= threshLow | data >= threshHigh;
        data(removeIdx) = nan;
    end
end