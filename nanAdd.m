function c = nanAdd(a,b)
%adds two numbers, if both nan re turn nan, if one is nan, return the non
%nan number
    if isnan(a) && isnan(b)
        c = nan;
    else
        c = sum([a,b],'omitnan');
    end
end
