function myTTest(data,names,type)
   %performs ttests between all pairs of inputs in data, and prints the
   %results. *Data* should be a cell array of arrays, which conrispont do the
   %cell array of *names*. *type* can iether be paired for a paried t test or
   %int for independent
   pairs = nchoosek(1:size(data,2),2);
   for k=1:size(pairs,1);
       if strcmp(type,'paired')
           [~,pVal,~,stats] = ttest(data{pairs(k,1)},data{pairs(k,2)},'tail','both');
       else
           [~,pVal,~,stats] = ttest2(data{pairs(k,1)},data{pairs(k,2)},'tail','both');
       end
       fprintf('TTest(%s) between %s and %s p=%0.7f (t=%.4f, df=%i)\n',type,names{pairs(k,1)},names{pairs(k,2)},pVal,stats.tstat,stats.df);
   end
end