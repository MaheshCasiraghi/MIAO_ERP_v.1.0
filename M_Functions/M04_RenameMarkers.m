% [EEG] = M04_RenameMarkers('sj01.set', 'C:\\SET', {'14' '18' '27' '36'}, {'S14' 'S18' 'S27' 'S36'}). Change the name of a defined array of markers into the value of the new array. Note that the new arrays have to be of the same size and that the new marker's name is saved in TYPE field, while a backup of the old name is stored in the OLDNAME field. It is possible to act on the line ################### in order to automatically delete the unmentioned markers.
function [EEG] = M04_RenameMarkers(filename, filepath, chanlistOLD, chanlistNEW)
% [EEG] = M04_RenameMarkers('sj01.set', 'C:\\SET', {'14' '18' '27' '36'}, {'S14' 'S18' 'S27' 'S36'}). Change the name of a defined array of markers into the value of the new array. Note that the new arrays have to be of the same size and that the new marker's name is saved in TYPE field, while a backup of the old name is stored in the OLDNAME field. It is possible to act on the line ################### in order to automatically delete the unmentioned markers.
EEG = pop_loadset('filename',filename,'filepath',filepath);
EEG = eeg_checkset( EEG );
eeglab redraw;

for i=1:length(chanlistNEW) 
   % EEG = pop_selectevent(EEG,'type', chanlistOLD(i), 'renametype', chanlistNEW(i), 'oldtypefield', chanlistOLD(i));
   [EEG l] = pop_selectevent(EEG,'type', chanlistOLD(i), 'renametype', char((chanlistNEW(i))), 'oldtypefield', 'OLDNAME');
   eval(['Indices_' num2str(i) '= length(l);'])
end

EEG = eeg_checkset( EEG );

%###################
% EEG = pop_selectevent(EEG,'type',chanlistNEW, 'deleteevents','on');
%###################

for i=1:length(chanlistNEW); 
eval(['MRK_' num2str(i) '= length (strmatch(char((chanlistNEW(i))), {EEG.event.type}, ''exact''));']);
end

for i=1:length(chanlistNEW);
    if eval(['Indices_' num2str(i)])~= 0;
        disp(cell2str([num2str(eval(['MRK_' num2str(i)])) 'markers' chanlistOLD(i) 'have been' 'replaced' 'by markers:' chanlistNEW(i)], ' '));
    else
        disp(cell2str(['ATTENTION: No markers' chanlistOLD(i) 'have been' 'retrieved and replaced' 'by markers:' chanlistNEW(i)], ' '));
    end
end
disp(['========================================================================='])
EEG = pop_saveset(EEG, 'filename',['New_markered_' filename],'filepath',filepath);
disp(['========================================================================='])
disp(['Done, a new file named: ' ['New_markered_' filename] ' has been saved in:'])
disp (filepath)
disp(['========================================================================='])

end

