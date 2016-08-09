function t=removeOutliers(t)
    for i=1:size(t,2)
        t{:,i} = remove2SD(t{:,i});
    end
end