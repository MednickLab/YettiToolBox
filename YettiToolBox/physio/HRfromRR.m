function [hr] = HRfromRR(rrPeakLocs,sampleRate)
    if length(rrPeakLocs) < 2
        hr = nan;
    else
        RRDiff = diff(rrPeakLocs);

        %% HR
        hrBPM = 60./(RRDiff./sampleRate); %in BPM
        hrBPM = hrBPM((35 < hrBPM) & (hrBPM< 140));
        hr = mean(hrBPM);
    end
    
end