function [sA] = matchVariableNames(sA,sB)
    %Creates nan filed variables in sA so that it matchs the variables in
    %sB. Size of variable in sA will be max height of variable in sA.
    %Handles structures and tables.
    fNamesA = fieldnames(sB);
    fNamesB = fieldnames(sA);
    fNamesA(strcmp(fNamesA,'Properties')) = [];
    fNamesA(strcmp(fNamesA,'Row')) = [];
    fNamesA(strcmp(fNamesA,'Variables')) = [];
    fNamesB(strcmp(fNamesA,'Properties')) = [];
    fNamesB(strcmp(fNamesA,'Row')) = [];
    fNamesB(strcmp(fNamesA,'Variables')) = [];
    if isstruct(sA)
        maxLen = max(structfun(@(x) size(x,1),sA(1)));
    else
        temp = varfun(@(x) size(x,1),sA);
        maxLen = max(temp{1,:});        
    end
    for i=1:length(fNamesA)
        if sum(strcmp(fNamesA{i},fNamesB))
            continue;
        end
        if isstruct(sA)
            try
            a = [sB.(fNamesA{i})];
            if iscell(a(1))
                sA.(fNamesA{i})=repmat({nan},maxLen,1);
            else
                sA.(fNamesA{i})=nan(maxLen,1);
            end
            catch err
                disp
            end
        else
            if iscell(sB.(fNamesA{i})(1))
                sA.(fNamesA{i})=repmat({nan},maxLen,1);
            else
                sA.(fNamesA{i})=nan(maxLen,1);
            end          
        end
    end
end