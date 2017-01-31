function jitter = jitterTime(jitterSecs)
    % jitterSecs the time to jitter between in seconds
    % jitter will be +-jitterSecs/2
    %Seed rand num generator before using this function
    jitter = jitterSecs*rand-jitterSecs/2;
end
