function tParent = recursiveNestedStruct2Table(level,nameOfLevel)
    %Takes a nested structure (level) and returns a flat table in 'long' form.
    if numel(level)>1 %we have a struct array
        %level = fillBlankStructArrayRowWithTopRowValues(level);
        tParent = struct2table(rotateAndFillStruct(level(1))); %so deal with the first one
        tParent.(nameOfLevel) = ones(height(tParent),1);
        tParent = [tParent(:,end) tParent(:,1:end-1)];
        for s=2:numel(level)
            tUpperTemp = struct2table(rotateAndFillStruct(level(s))); % then every other one
            tUpperTemp.(nameOfLevel) = s*ones(height(tParent),1);
            tUpperTemp = [tUpperTemp(:,end) tUpperTemp(:,1:end-1)];
            tUpperTemp = matchVariableNames(tUpperTemp,tParent);
            tParent = [tParent ; tUpperTemp]; %and concatinate them all together
        end
    else %assumes we have a one level struct
        tParent = struct2table(rotateAndFillStruct(level));        
    end
    fNames = fieldnames(tParent);
    fNames = fNames(~strcmp(fNames,'Properties'));
    if ~iscell(fNames)
        fNames = {fNames};
    end
    
    [tParent,structCols] = sortNonStructColsToLeft(tParent);
    if isempty(structCols)
        return
    end
    tRow = cell(height(tParent),1);
    for row = 1:height(tParent) %step through each row       
        tChildren = cell(size(structCols));        
        for col = structCols;  %Step through cols that contain structs.
            tChildren{col==structCols} = recursiveNestedStruct2Table(tParent{row,col},tParent.Properties.VariableNames{col}); %recursive call
            tChildren{col==structCols}.(tParent.Properties.VariableNames{col}) = row*ones(height(tChildren{col==structCols}),1); 
            tChildren{col==structCols} = [tChildren{col==structCols}(:,end) tChildren{col==structCols}(:,1:end-1)];
            tChildren{col==structCols} = prependToAllTableVariableNames(tChildren{col==structCols},tParent.Properties.VariableNames{col});
        end
        maxHeight = max(cellfun(@height,tChildren));
        tChildren = cellfun(@(x) struct2table(fillNans(myTable2Struct(x),maxHeight)),tChildren,'UniformOutput',false);
        nonStructs = repmat(tParent(row,1:structCols(1)-1),maxHeight,1);
        tRow{row} = [nonStructs tChildren{:}];
    end
    
        
    tParent = tRow{1};
    for rIdx=2:length(tRow)
        tParent = matchVariableNames(tParent,tRow{rIdx});
        tRow{rIdx} = matchVariableNames(tRow{rIdx},tParent);
        tParent = [tParent ; tRow{rIdx}];
    end
       
    function A = rotateAndFillStruct(A)
        %Fill coloumns with nans or {nans} until all cols have matching
        %number of elements
        A = structRowsToCols(A);
        heights = structfun(@(x) size(x,1),A);
        A = fillNans(A,max(heights));        
    end
    
    function A = fillNans(A,maxHeight)
        %adds Nans table or struct *A* so that all feilds are *maxHeight*
        fNames_ = fieldnames(A);
        fNames_ = fNames_(~strcmp(fNames_,'Properties'));
        for r = 1:length(fNames_)
            if isempty(A.(fNames_{r}))
                A = rmfield(A,fNames_{r});
            elseif isstruct(A.(fNames_{r})(1))
                A.(fNames_{r}) = [A.(fNames_{r}) ; repmat(struct(A.(fNames_{r})),maxHeight-length(A.(fNames_{r})),1)];
            elseif iscell(A.(fNames_{r})(1))
                A.(fNames_{r}) = [A.(fNames_{r}) ; repmat(num2cell(nan(size(A.(fNames_{r})(1,:)))),maxHeight-length(A.(fNames_{r})),1)];
            elseif ischar(A.(fNames_{r}))
                A.(fNames_{r}) = [{A.(fNames_{r})} ; repmat({''},maxHeight-1,1)];
            else
                A.(fNames_{r}) = [A.(fNames_{r}) ; nan(maxHeight-length(A.(fNames_{r})),1)];
            end
        end
    end

    function t = prependToAllTableVariableNames(t,str2prepend)
        for vName = 1:length(t.Properties.VariableNames)
            t.Properties.VariableNames{vName} = [str2prepend '_' t.Properties.VariableNames{vName}];
        end
    end

    function [t,structCols] = sortNonStructColsToLeft(t) 
        %All feilds containing structs are pushed to the right of the table *t*, all non-structs are pushed to the left        
        hasStruct = varfun(@(x) isstruct(x), t(1,:));
        [structCols,sortIdx] = sort(hasStruct{1,:});
        t = t(:,sortIdx);
        structCols =find(structCols);
    end

    function sA = fillBlankStructArrayRowWithTopRowValues(sA)
        vNames = fieldnames(sA);
        for sRow=2:numel(sA)
            for v = 1:length(vNames)
                if isempty(sA(sRow).(vNames{v})) || isnan(sA(sRow).(vNames{v})) || (iscell(sA(sRow).(vNames{v})) && isnan(sA(sRow).(vNames{v}){1}))
                   sA(sRow).(vNames{v}) = sA(sRow-1).(vNames{v});
                end
            end
        end
    end
end