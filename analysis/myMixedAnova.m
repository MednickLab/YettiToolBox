function myMixedAnova(y,cond1,cond1Lab,cond1Title,cond1Type,cond2,cond2Lab,cond2Title,cond2Type)
%A mixed level anova in matlab. This is where you have one contion (such as time) nested within a
%some grouping variable (such as subject) and then have some between subject variable (such as drug condition)
%
% *Y* is the input data, and should be a large list of outcome variables, one for each observation.
% IMPORTANT: if using a within subjects factor, Y data MUST be in correct subjects order.
% e.g. Subject1_time1, subject1_time2, subject2_time3, subject2_time1, subject2_time2 etc
%
% *cond1* is a cell array, each element in the cell array is a vector of ones and zeros specifing
% which group each data came from.
%   E.G. if there were 3 time points nested within subject, then this would be a 3x1 cell 
%        array where cond1{1} dicribing which observations were at time one.
%
% *cond1Lab* is a cell array of labels for condition one ({'Time1','Time2', etc})
%
% *cond1Title* is the name of the conditon one grouping variable (e.g. 'Time')
%
% *cond1Type* specifys the type of grouping, can be either 'within' (this variable is nested within
% subjects) or 'between' this varible is between subjects.
% 
% Variables are the same for cond2. Can handle any combination of within/between for 2 varaibles
% The grouping variable (i.e. which data belongs to which subjects) is internally generated. This
% 

%First we have to get rid of Nans. Count them first
nansToRemove = isnan(y);
for i=1:length(cond1)
    nansToRemove = nansToRemove | isnan(cond1{i});
end
for i=1:length(cond2)
    nansToRemove = nansToRemove | isnan(cond2{i});
end
%Remove em
y = y(~nansToRemove);
for i=1:length(cond1)
    cond1{i} = cond1{i}(~nansToRemove);
end
for i=1:length(cond2)
    cond2{i} = cond2{i}(~nansToRemove);
end
    
subs = 1:length(y);

dataForBar = cell(length(cond2),length(cond1));
subsFactorBothWithin = [];
subsFactorCond2Within = [];
for i=1:length(cond2) %rows: cond2
    for j=1:length(cond1) %cols: cond1
        dataForBar{i,j} = y(cond1{j} & cond2{i});
        subsFactorBothWithin = [subsFactorBothWithin 1:length(dataForBar{i,j})];
    end
    subsFactorCond2Within = [subsFactorCond2Within subs(cond2{i})];
end

dataForAnova = reshape(dataForBar',1,length(cond1Lab)*length(cond2Lab));
cond1Factor = [];
subsFactorCond1Within = [];
for i=1:size(dataForBar,1) %rows: cond2
    for j=1:size(dataForBar,2) %cols: cond1
        cond1Factor = [cond1Factor repmat(cond1Lab(j),1,length(dataForBar{i,j}))];
        subsCond2 = subs(cond2{i});
        subsFactorCond1Within = [subsFactorCond1Within subsCond2(1:length(dataForBar{i,j}))];
    end  
end

cond2Factor = [];
for i=1:size(dataForBar,1) %rows: cond2
    for j=1:size(dataForBar,2) %cols: cond1
        cond2Factor = [cond2Factor repmat(cond2Lab(i),1,length(dataForBar{i,j}))];
    end
end

figure
myBarWeb(dataForBar,'',cond1Lab,cond2Lab,'','',[],[],strcmp(cond1Type,'within'),strcmp(cond2Type,'within'))
if ~strcmp(cond1Type,'within') && ~strcmp(cond2Type,'within')
    groupForAnova = {cond1Factor;cond2Factor};
    yAnova = cell2mat(dataForAnova')';
    groupForAnova = cellfun(@(x) x(~isnan(yAnova)),groupForAnova,'UniformOutput',false);
    yAnova = yAnova(~isnan(yAnova));
    anovan(yAnova,groupForAnova,'model','interaction','varnames',{cond1Title,cond2Title});
elseif strcmp(cond1Type,'within') && strcmp(cond2Type,'within')
    groupForAnova = {cond1Factor;cond2Factor;subsFactorBothWithin};
    nesting = [0 0 0; 0 0 0; 0 0 0];
    anovan(cell2mat(dataForAnova')',groupForAnova,'model','interaction','varnames',{cond1Title,cond2Title,'Subs'},'random',3,'nested',nesting);
elseif strcmp(cond1Type,'within') && ~strcmp(cond2Type,'within')
    groupForAnova = {cond1Factor;cond2Factor;subsFactorCond1Within};
    nesting = [0 0 0; 0 0 0; 0 1 0];
    anovan(cell2mat(dataForAnova')',groupForAnova,'model','interaction','varnames',{cond1Title,cond2Title,'Subs'},'random',3,'nested',nesting);
elseif ~strcmp(cond1Type,'within') && strcmp(cond2Type,'within')
    error('Cond 2 within and condition 1 between is not supported, try swapping cond1 with cond2')
end

end