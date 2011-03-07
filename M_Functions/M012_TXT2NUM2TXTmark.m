%EEG = M012_TXT2NUM2TXTmark('sj01.set', 'C:\Users\Mahesh Casiraghi\Documents\MATLAB\Data\SET\Sample\sj01\FASTER SAMPLE')
function [EEG] = M012_TXT2NUM2TXTmark(filename, filepath)
%EEG = M012_TXT2NUM2TXTmark('sj01.set', 'C:\Users\Mahesh Casiraghi\Documents\MATLAB\Data\SET\Sample\sj01\FASTER SAMPLE')

EEG = pop_loadset('filename',filename,'filepath',filepath);

if ischar(EEG.event(1).type) == 1;
TotalMarkers={EEG.event.type};
for i=1:length(TotalMarkers)
EEG.event(i).type=str2num(EEG.event(i).type);
end
numerico=1;
else
TotalMarkers={EEG.event.type};
for i=1:length(TotalMarkers);
EEG.event(i).type=num2str(EEG.event(i).type);
end
TotalMarkers={EEG.event.type};
numerico=1;
end
end




