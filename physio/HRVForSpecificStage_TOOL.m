%A tool to output HRV information for consecuive periods of the same
%stage. Details:
%
% 
% The follwing rules are be applied:
% 1) find 2 minutes of a single stage (e.g., N2,N2,N2,N2)
% 2) check if the next 5-min are of the same stage (N2 x10). If there is any "sleep transition" (e.g., N2,N2, REM, N2, etc...), start again with #1. If so, select this as a "bin" and run HRV analysis on it and skip to #3.
% 3) continue as 2.
%
%The stage labels are:
% 0=W
% 1=N1
% 2=N2
% 3=N3/SWS
% 5=REM
clear
addpath('../')
priorToBinEpochs = 2;
binLengthInEpochs = 10;
epochLen = 30; %30 second epoch len

stageIDs = [0,1,2,3,5];

%Uncomment this if you want to import single file from Kubious
%HRVFiles = {'D:\Users\Ben\Downloads\XXYY'};
%Uncomment this if you want to import all the files at the location specified here:
pathToKubiousFiles = 'D:\Users\Ben\Downloads\';
HRVFiles = getFileNamesThatContain(pathToKubiousFiles,{'hrv'},'.mat');

%Import corrisponding stage information for the files:
stageFileFolder = 'D:\Users\Ben\Downloads\';%This is the folder location where we should look for stage files.


for f=1:length(HRVFiles)
    [~,fname,~] = fileparts(HRVFiles{1});
    stageFileName = fname(1:end-4);%Stage files must be named like xx.
    stageFile = [stageFileFolder stageFileName '.txt'];
    try
        sFile = readtable(stageFile,'delimiter','tab','ReadVariableNames',false);
        stages = sFile{:,2};
    catch err
        warning('No matching stage file for %s, skipping this record',stageFile);
        continue;
    end
    hrvFile = load(HRVFiles{f});
    rrPeaksInSecs = hrvFile.Res.HRV.Data.T_RRs{1};
    stageChunks = consecutiveValues(stages');
    validChunks = find(stageChunks.lengthSeqs>(priorToBinEpochs+binLengthInEpochs));
    HRVStruct = struct();
    binIdx = 1;
    cIdx = 0;
    for c = validChunks
        if ~any(stageChunks.vals(c)==stageIDs) %If this stage is not one we are interested in
            continue
        end
        cIdx = cIdx+1;
        splits = floor((stageChunks.lengthSeqs(c)-priorToBinEpochs)/binLengthInEpochs);
        s=1;
        for s=1:splits
            HRVStruct.continousStageID(binIdx) = cIdx;
            HRVStruct.binNumInContinousStage(binIdx) = s;
            HRVStruct.stage(binIdx) = stageChunks.vals(c);
            HRVStruct.startEpoch(binIdx) = stageChunks.startSeqs(c)+priorToBinEpochs+(s-1)*binLengthInEpochs;
            HRVStruct.endEpoch(binIdx) = HRVStruct.startEpoch(binIdx)+binLengthInEpochs;
            HRVStruct.startTime(binIdx) = HRVStruct.startEpoch(binIdx)*epochLen;                         
            HRVStruct.endTime(binIdx) = HRVStruct.endEpoch(binIdx)*epochLen;
            HRVStruct.duration(binIdx) = binLengthInEpochs*epochLen;
            rrPeaksInSecs = rrPeaksInSecs-rrPeaksInSecs(1); %start at 0 seconds
            rrForBin = rrPeaksInSecs(rrPeaksInSecs > HRVStruct.startTime(binIdx) & rrPeaksInSecs < HRVStruct.endTime(binIdx));
            HRVBinData = HRVPower(rrForBin);
            HRVStruct.nLF(binIdx) = HRVBinData.nLF;
            HRVStruct.nHF(binIdx) = HRVBinData.nHF;
            HRVStruct.HF(binIdx) = HRVBinData.HF;
            HRVStruct.LF(binIdx) = HRVBinData.LF;
            HRVStruct.meanHR(binIdx) = HRVBinData.meanHR;
            HRVStruct.TP(binIdx) = HRVBinData.TP;
            HRVStruct.lnTP(binIdx) = HRVBinData.lnTP;
            HRVStruct.LF_HF_Ratio(binIdx) = HRVBinData.LF_HF_Ratio;
            HRVStruct.lnHF(binIdx) = HRVBinData.lnHF;
            HRVStruct.lnLF(binIdx) = HRVBinData.lnLF;
            %Some other feilds
            binIdx = binIdx+1;
        end
    end
    HRVStruct = structRowsToCols(HRVStruct);
    HRVtable = struct2table(HRVStruct);
    writetable(HRVtable,[pathToKubiousFiles stageFileName '_HRVBinAnalysis.xlsx']);
end






