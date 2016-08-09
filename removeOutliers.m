function t=removeOutliers(t)
    for i=1:size(t,2)
        t{:,i} = removeSD(t{:,i},2.5);
    end
end