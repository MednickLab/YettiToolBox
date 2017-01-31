function setupWhiteNoiseBurst(ptb,secsOfSound,secsOfRamp)
    whiteNoiseBurst = rand(1,ptb.audioSampleRate*secsOfSound);
    if exist('secsOfRamp','var') && secsOfRamp~=0
        samplesForRamp = ptb.audioSampleRate*secsOfRamp;
        ramp = 1:samplesForRamp;
        ramp  = ramp/max(ramp);
        fullRamp = [ramp ones(1,length(whiteNoiseBurst)-length(ramp)*2) ramp];
        whiteNoiseBurst = whiteNoiseBurst.*fullRamp;
    end   
    PsychPortAudio('FillBuffer',ptb.audioPort,whiteNoiseBurst)
end