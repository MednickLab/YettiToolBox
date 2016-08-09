function [params,counts,centers,edges] = plotJagsOutput(jagsSamples)
    fns = fieldnames(jagsSamples);
    for f=1:length(fns)            
        for k=1:size(jagsSamples.(fns{f}),5) 
            figure
            x=1;
            for j=1:size(jagsSamples.(fns{f}),4)  
                for i=1:size(jagsSamples.(fns{f}),3)                         
                    subplot(size(jagsSamples.(fns{f}),3),size(jagsSamples.(fns{f}),4),x)
                    x = x+1;
                    posteriorData = jagsSamples.(fns{f})(:,:,i,j,k);
                    [counts.(fns{f}),centers.(fns{f}),edges.(fns{f})] = myHistogram(posteriorData,[],[],[fns{f} 'i=' num2str(i) 'j=' num2str(j) 'k=' num2str(k)],'P(x)','x');
                    mu = mean(mean(posteriorData));
                    if ~strcmp(fns{f},'deviance')
                        params.(fns{f})=mu;
                    else
                        params.finalDevience = mean(posteriorData);
                        params.finalDevience = params.finalDevience(end);
                    end
                    ylims = ylim();
                    xlims = xlim();
                    xRange = xlims(2)-xlims(1);
                    line([mu mu],ylims,'Color','r');
                    text(mu+0.05*xRange,ylims(2)*0.9,sprintf('Mean: %.4f',mu))
                end
            end
        end
    end
end