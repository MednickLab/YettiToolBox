function x = nanzscore(X)
    if isrow(X)
        X = X';
    end
    xmu=nanmean(X);
    xsigma=nanstd(X);
    x=(X-repmat(xmu,length(X),1))./repmat(xsigma,length(X),1);
    if isrow(X)
        x = x';
    end
end