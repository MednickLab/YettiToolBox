function loadSound(ptb,soundToPlay)
%plays a sound using default speakers. The *soundToPlay* is the name of the
%wav sound file to play (inc filetype). If a path is specified the sound will be looked up from there.
%Included defaults are:
% - 'dading.wav'
% - ...
% Addtional sounds can be added to the sound folder in the
% yettitoolbox
[d] = fileparts(soundToPlay);
if isempty(d)
    tbDir = fileparts(which(mfilename));
    soundToPlay = [tbDir filesep 'sounds' filesep soundToPlay];
end
[s,fs] = audioread(soundToPlay);

sound(s,fs);
end