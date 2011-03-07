% [EEG] = M06_DeleteMarkers('sj01.set', 'C:\\SET', {'S14' 'S18' 'S27' 'S36'}). INDICATE THE ONES TO DELETE!. Note that the information is the one contained in the TYPE field. Juste change the field below to intervene in function of other fields. A new file named Markers_deleted_filename will be saved in the same folder of the original file.
function [EEG] = M06_DeleteMarkers(filename, filepath, chanlist)
% [EEG] = M06_DeleteMarkers('sj01.set', 'C:\\SET', {'S14' 'S18' 'S27' 'S36'}). INDICATE THE ONES TO DELETE!. Note that the information is the one contained in the TYPE field. Juste change the field below to intervene in function of other fields. A new file named Markers_deleted_filename will be saved in the same folder of the original file.
EEG = pop_loadset('filename',filename,'filepath',filepath);
EEG = eeg_checkset( EEG );
eeglab redraw;
TotalMarkers={EEG.event.type};
Totale=(length(TotalMarkers));
[EEG l] = pop_selectevent(EEG,'omittype', chanlist, 'deleteevents','on');
Indices = length(l);
Tolti=(Totale - Indices);
Furono=num2str(Tolti);
EEG = eeg_checkset( EEG );
disp(['========================================================================='])
    if Indices ~= Totale;
        disp(['A total number of: ' Furono ' markers' ' have been' ' deleted.']);
        disp(['A total number of: ' num2str(Indices) ' markers are' ' left.']);
    else
        disp(['ATTENTION: No' ' markers' ' have been' ' deleted.']);
    end
disp(['========================================================================='])
EEG = pop_saveset(EEG, 'filename',['Markers_deleted_' filename],'filepath',filepath);
disp(['========================================================================='])
disp(['Done, a new file named: ' ['Markers_deleted_' filename] ' has been saved in:'])
disp (filepath)
disp(['========================================================================='])

end


