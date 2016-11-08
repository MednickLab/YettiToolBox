%A tool to output HRV information for consecuive periods of specific stages. 
% You will need:
% a) A file containing RR peaks (in seconds) in Kubious .mat output format
% (filename like: "SUBJECTID_hrv.mat").
% b) A tab delimited stage file where the second colomn is stages, and no header.
%   (filename like: "SUBJECTID.txt"). Stage file and RR file should be
%   timesynced
%   The stage labels are:
%   0=W
%   1=N1
%   2=N2
%   3=N3/SWS
%   5=REM
%
% The follwing rules will be applied:
% 1) Find continous blocks of any of the stages defined in *stageIDs*
% 2) For all continous blocks greater than *priorToBinEpochs*+*binLengthInEpochs* length: 
%   3) Discard first *priorToBinEpochs* of that stage
%   4) For every consecuive *binLengthInEpochs* chunk after the discarded
%      chunk, run HRV calculations
% 3) Print all analysised continous blocks (called bins) to xlsx file.
%
% This function requires other functions from the yettiToolBox (getFileNamesThatContain, consecutiveVals)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2016, Benjamin Yetton
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 1. Redistributions of source code must retain the above copyright
%    notice, this list of conditions and the following disclaimer.
% 2. Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the distribution.
% 3. All advertising materials mentioning features or use of this software
%    must display the following acknowledgement:
%    This product includes software developed by the Mednick Lab.
% 4. Neither the name of the Mednick Lab nor the
%    names of its contributors may be used to endorse or promote products
%    derived from this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY Benjamin Yetton ''AS IS'' AND ANY
% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL Benjamin Yetton BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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






