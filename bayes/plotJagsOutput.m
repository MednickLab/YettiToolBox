function plotJagsOutput(jagsSamples)
    fns = fieldnames(jagsSamples);
    for f=1:length(fns)
        figure        
        histogram(jagsSamples.(fns{f}));
        mu = mean(mean(jagsSamples.(fns{f})));
        ylims = ylim();
        xlims = xlim();
        xRange = xlims(2)-xlims(1);
        line([mu mu],ylims,'Color','r');
        text(mu+0.05*xRange,ylims(2)*0.9,sprintf('Mean: %.4f',mu))
        title(fns{f});
    end
end