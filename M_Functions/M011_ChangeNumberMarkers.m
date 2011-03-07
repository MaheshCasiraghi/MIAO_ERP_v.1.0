%EEG = M011_ChangeNumberMarkers('sj01.set', 'C:\Users\Mahesh Casiraghi\Documents\MATLAB\Data\SET\Sample\sj01\FASTER SAMPLE', '-65280')
function [EEG] = M011_ChangeNumberMarkers(filename, filepath, operation)
%EEG = M011_ChangeNumberMarkers('-65280')

EEG = pop_loadset('filename',filename,'filepath',filepath);
EEG = eeg_checkset( EEG );
pippo={EEG.event.type};
for i=1:length(pippo);
a(i)=cell2mat(pippo(i));
a(i) = eval(['a(i)' num2str(operation)]);
pippo(i)=num2cell(a(i));
end

for i=1:length(pippo);
EEG.event(i).type=cell2mat(pippo(i));
end

end

