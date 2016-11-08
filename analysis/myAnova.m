function myAnova(y,grouping,xLab)
    if exist('xLab','var')
        ps = anovan(y,grouping,'model','interaction','varnames',xLab);
    else
        ps = anovan(y,grouping,'model','interaction');
    end
end