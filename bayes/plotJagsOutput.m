function [params,counts,centers,edges] = plotJagsOutput(jagsSamples)
    fns = fieldnames(jagsSamples);
    for f=1:length(fns)
        posteriorData = jagsSamples.(fns{f});
        [counts.(fns{f}),centers.(fns{f}),edges.(fns{f})] = myHistogram(posteriorData,[],[],fns{f},'P(x)','x');
        mu = mean(mean(posteriorData));
        if ~strcmp(fns{f},'deviance')
            params.(fns{f})=mu;
             ylims = ylim();
             xlims = xlim();
             xRange = xlims(2)-xlims(1);
             text(mu+0.05*xRange,ylims(2)*0.9,sprintf('Mean: %.4f',mu))
             line([mu mu],ylims,'Color','r');
        else
            params.finalDevience = mean(posteriorData);
            params.finalDevience = params.finalDevience(end);
        end
                             
    end
end