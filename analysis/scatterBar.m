function scatterBar(data, labels)
%creates a nice scatter chart that resembles a bar plot. *data* is a cell
%array of condition samples, and the *labels* are the names of the
%condition

figure
hold on
for i=1:length(data)
    plot(i*ones(size(data{i})),data{i},'o');
    plot(i,mean(data{i}),'*')
    plot([i i],[mean(data{i}) mean(data{i})+std(data{i})] ,'-')
end
xlim([0 (length(labels)+1)])
set(gca,'Xtick',1:(length(labels)),'XTickLabel',['' labels ''])
hold off

end