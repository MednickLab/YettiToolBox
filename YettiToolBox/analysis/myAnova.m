function myAnova(y,X,tit,ylab,xlab,omitOutliers) 
    anovan(y,X,'model','interaction','varnames',xlab)
    %modelspec = 'y ~ cond*room';
    %fitglm(X,y,modelspec)
end