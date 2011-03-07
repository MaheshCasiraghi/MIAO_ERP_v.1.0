%EEG =M020_GroupMarkersin1Marker('sj01.set', 'C:\SETs', 300, 370, 99)
function [EEG] = M020_GroupMarkersin1Marker(filename, filepath, lowerboundinterval, upperboundinterval, newcode)
%EEG = M020_GroupMarkersin1Marker('sj01.set', 'C:\SETs', lowerboundinterval, upperboundinterval, newcode)
EEG = pop_loadset('filename',filename,'filepath',filepath);
EEG = eeg_checkset( EEG );
pippo={EEG.event.type};
for i=1:length(pippo);
a(i)=cell2mat(pippo(i));
if [a(i)>=lowerboundinterval a(i)<=upperboundinterval] == [1 1]; 
%fprintf([num2str(a(i)) '\n']) 
EEG.event(i).type = newcode;
end
end

%for i=1:length(pippo);
%EEG.event(i).type=cell2mat(pippo(i));
%end

end

