function myPiePlot(proportions,labels,myTitle,type,plotly)   
    h = pie(proportions/sum(proportions));
    if ~exist('type','var')
        if ~exist('labels','var')
        	type = 0;
        else
            type = 1;
        end
    end
    if type==1 && exist('labels','var') && ~isempty(labels)
    hText = findobj(h,'Type','text'); % text object handles
    percentValues = get(hText,'String'); % percent values
    combinedstrings = strcat(labels',repmat({': '},length(labels),1),percentValues); % strings and percent values
    oldExtents_cell = get(hText,'Extent'); % cell array
    oldExtents = cell2mat(oldExtents_cell); % numeric array
    for i=1:length(combinedstrings)
        hText(i).String = combinedstrings(i);
    end
    signValues = sign(oldExtents(:,1));   
    newExtents_cell = get(hText,'Extent'); % cell array
    newExtents = cell2mat(newExtents_cell); % numeric array
    width_change = newExtents(:,3)-oldExtents(:,3);
    offset = signValues.*(width_change/2);
    textPositions_cell = get(hText,{'Position'}); % cell array
    textPositions = cell2mat(textPositions_cell); % numeric array
    textPositions(:,1) = textPositions(:,1) + offset; % add offset
    hText(1).Position = textPositions(1,:);
    hText(2).Position = textPositions(2,:);
    elseif type==2 && exist('labels','var') && ~isempty(labels)
        legend(labels)
    end
    if exist('myTitle','var') && ~isempty(myTitle)
        title(myTitle)
    else
        myTitle = '';
    end
    if exist('plotly','var') && ~isempty(plotly)
        fig2plotly()
    end
end