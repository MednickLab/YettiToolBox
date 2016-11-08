function HRV_out = HRVPower(RPeaksInSecs) %
clc
% - If you have the R peaks in samples, devide the Rpeaks vector by sampling frequency and apply to the function  
% - The output values are based on RR values in msec

fi=4; % interpolation frequency =4 Hz
if (floor(RPeaksInSecs(2))-RPeaksInSecs(2))==0
    warning='You may be using Rpeaks in samples (not secs). Be careful!'
end

RR=RPeaksInSecs(2:end)-RPeaksInSecs(1:end-1);
RR_time=RPeaksInSecs(2:end);
wrng_low=find(RR<0.4);
if ~isempty(wrng_low)
    warning=['You may have wrongly detected R peaks (RR< 0.4 s) at t=' num2str(RPeaksInSecs(wrng_low+1))]
end
wrng_hi=find(RR>1.65);
if ~isempty(wrng_hi)
    warning=['You may have undetected R peaks in ' num2str(RPeaksInSecs(wrng_hi)) '<t<' num2str(RPeaksInSecs(wrng_hi+1))]
end

HR=60./RR;
RR=RR*1000;
dnn=abs(RR(2:end)-RR(1:end-1));
HRV_out.meanRR=mean(RR);
HRV_out.SDNN=std(RR);
HRV_out.SDSD=std(dnn);
HRV_out.RMSSD=sqrt(sum(dnn.^2)./(length(dnn)-1));
HRV_out.pNN50=length(find(dnn>50))/length(dnn)*100;
HRV_out.meanHR=mean(HR);
HRV_out.SDHR=std(HR);

RRts=spline(RR_time,RR,RR_time(1):1/fi:RR_time(end)); % time-series of RR intervals
if (RR_time(end)-RR_time(1))>256  % 256 seconds around 4.26 minutes
    pw_an_win=256;
    pw_an_ovlp=128;
elseif (RR_time(end)-RR_time(1))>128  % 128 seconds around 2.13 minutes
    pw_an_win=128;
    pw_an_ovlp=64;
elseif (RR_time(end)-RR_time(1))>64  % 64 seconds around 1.07 minutes
    pw_an_win=64;
    pw_an_ovlp=32;
elseif (RR_time(end)-RR_time(1))>32  % 32 seconds around half a minutes
    pw_an_win=32;
    pw_an_ovlp=16;
    warning='You really need a longer data for frequency domain analysis'
elseif (RR_time(end)-RR_time(1))<32  
    warning='Data length is less than half a minute--> no Freq domain analysis'
end
[pxx,f]=pwelch(detrend(RRts),pw_an_win*fi,pw_an_ovlp*fi,0:1/pw_an_win:0.5,fi);
HRV_out.freqs=f;
HRV_out.PSD=pxx;
HRV_out.TP=sum(pxx(find(f>=0.04 & f<0.4))./pw_an_win);
HRV_out.LF=sum(pxx(find(f>=0.04 & f<0.15))./pw_an_win);
HRV_out.HF=sum(pxx(find(f>=0.15 & f<0.4))./pw_an_win);
HRV_out.lnTP = log(TP);
HRV_out.lnLF = log(LF);
HRV_out.lnHF = log(HF);
HRV_out.LF_HF_Ratio = HRV_out.LF/HRV_out.HF;
HRV_out.nLF=HRV_out.LF/(HRV_out.LF+HRV_out.HF);   % VLF ignored
HRV_out.nHF=1-HRV_out.nLF;