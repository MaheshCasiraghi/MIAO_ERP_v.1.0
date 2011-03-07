%[EEG] = M01_BDF2SET('sj01.bdf','C:\\BDFs\','sj01.set','C:\\SETs\',[65,66])
function [EEG] = M01_BDF2SET(filename, filepath, newfilename, newfilepath, referencechannels)
%[EEG] = M01_BDF2SET('sj01.bdf','C:\\BDF','sj01.set','C:\\SET',[65,66])
EEG = pop_biosig(cell2str([filepath filename],''), 'ref',referencechannels ,'blockepoch','off'); 
EEG = pop_saveset( EEG, 'filename',newfilename,'filepath',newfilepath);
EEG.setname = newfilename;
eeglab redraw;
end

