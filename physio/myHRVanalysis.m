function out=myHRVanalysis(RR_ind,sampleRate) % RR_ind: R peak indices from a ~3-minute epoch
%  ECG sampling frequency : sampleRate Hz
[r,~]=size(RR_ind);
nn=[]; hr=[]; dnn=[];
xx=[];
for i=1:r
    x=RR_ind{i,1};
    rr=(x(2:end)-x(1:end-1))./sampleRate*1000; % RR values in msec
    hr=[hr 60./(rr./1000)];
    nn=[nn rr];
    dnn=[dnn abs(rr(2:end)-rr(1:end-1))];
    
    rrts=spline(x(2:end),rr,x(2):x(end)); 
    rrts(1:2:end)=[]; 
    rrts(1:2:end)=[];
    rrts(1:2:end)=[]; rrts(1:2:end)=[]; rrts(1:2:end)=[]; rrts(1:2:end)=[]; % Down-sampling to 4 Hz
    rrts=rrts-mean(rrts);
    %fs=4;
    xx=[xx;rrts(1:64*4);rrts(48*4+1:(48+64)*4)]; % 64-sec windows with 16-sec overlap
    if length(rrts)>=640
        xx=[xx;rrts(96*4+1:(96+64)*4)];
    else
    xx=[xx;[rrts(96*4+1:end) zeros(1,sampleRate-length(rrts(96*4+1:end)))]];
    end
end
HRmean=mean(hr);
HRstd=std(hr);
NNmean=mean(nn);
SDNN=std(nn);
SDSD=std(dnn);
RMSSD=sqrt(sum(dnn.^2)./(length(dnn)-1));
pNN50=length(find(dnn>50))/length(dnn)*100;
[rx,~]=size(xx);
for i=1:rx
    XX(i,:)=abs(fft((xx(i,:).*hanning(sampleRate)'))).^2;
end
XX=XX(:,1:128);
P=mean(XX);
%ff=0:2/128:2-2/128;
LF=sum(P(4:10));
HF=sum(P(11:27));
nLF=LF/(LF+HF);
nHF=HF/(LF+HF);
LFHF_ratio=LF/HF;
out(1,1)=HRmean;
out(1,2)=HRstd;
out(1,3)=NNmean;
out(1,4)=SDNN;
out(1,5)=SDSD;
out(1,6)=RMSSD;
out(1,7)=pNN50;
out(1,8)=nLF;
out(1,9)=nHF;
out(1,10)=LFHF_ratio;
