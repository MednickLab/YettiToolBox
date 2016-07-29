function spagettiPlot(data,labels,annotations,condition)
%% draw a spagetti plot where rows in *data* are each subject (spagetti noodle) and the columns are the conditions/timepoints.
%% Condition names are in *labels* and each datapoint can have optional *annotations* where each datapoint in *data* corresponds to a annotation in *annotations*
    figure
    hold on
    for i=1:size(data,1)
        if condition(i)
            plot(1:size(data,2),data(i,:),'LineStyle','--');
        else
            plot(1:size(data,2),data(i,:));
        end
        if exist('annotations','var')
            for j=1:size(data,2)
                text(j+rand(1)*0.05,data(i,j),annotations(i,j))
            end  
        end
    end
    set(gca,'Xtick',1:length(labels),'XTickLabel',labels)
    hold off
end