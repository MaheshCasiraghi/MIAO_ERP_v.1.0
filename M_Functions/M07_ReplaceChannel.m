% [EEG Canali] = M07_ReplaceChannel ('sj01.set', 'C:\SETs', {'EXG4' 'EXG5' 'EXG6' 'EXG7'}, {'Fp1' 'Fp2' 'PO7' 'PO8'}). Replaces one or more channels of the EEG Dataset with the new channels. THE FIRST ARRAY IS THE ONE THAT WILL BE REPLACED! Note that changes will be saved in a new dataset named: 'Channels_replaced_filename'.      
function [EEG Canali] = M07_ReplaceChannel(filename, filepath, chanlistOLD, chanlistNEW)
% [EEG Canali] = M07_ReplaceChannel ('sj01.set', 'C:\SETs', {'EXG4' 'EXG5' 'EXG6' 'EXG7'}, {'Fp1' 'Fp2' 'PO7' 'PO8'}). Replaces one or more channels of the EEG Dataset with the new channels. THE FIRST ARRAY IS THE ONE THAT WILL BE REPLACED! Note that changes will be saved in a new dataset named: 'Channels_replaced_filename'.      
EEG = pop_loadset('filename',filename,'filepath',filepath);
EEG = eeg_checkset( EEG );
eeglab redraw;

for i=1:length(chanlistNEW) 
   % EEG = pop_selectevent(EEG,'type', chanlistOLD(i), 'renametype', chanlistNEW(i), 'oldtypefield', chanlistOLD(i));
   NewID=M08_GetChanNum(EEG,chanlistNEW(i));
   OldID=M08_GetChanNum(EEG,chanlistOLD(i));
   EEG.chanlocs(OldID).labels=EEG.chanlocs(NewID).labels;
   EEG.chanlocs(OldID).urchan=EEG.chanlocs(NewID).urchan;
   EEG.chanlocs(OldID).radius=EEG.chanlocs(NewID).radius;
   EEG.chanlocs(OldID).X=EEG.chanlocs(NewID).X;
   EEG.chanlocs(OldID).Y=EEG.chanlocs(NewID).Y;
   EEG.chanlocs(OldID).Z=EEG.chanlocs(NewID).Z;
   EEG.chanlocs(OldID).sph_theta=EEG.chanlocs(NewID).sph_theta;
   EEG.chanlocs(OldID).sph_phi=EEG.chanlocs(NewID).sph_phi;
   EEG.chanlocs(OldID).sph_radius=EEG.chanlocs(NewID).sph_radius;
   EEG.chanlocs(OldID).type=EEG.chanlocs(NewID).type;
   EEG.chanlocs(OldID).ref=EEG.chanlocs(NewID).ref;
   EEG.chanlocs(OldID).labels=EEG.chanlocs(NewID).labels;
   EEG.chanlocs(OldID).labels=EEG.chanlocs(NewID).labels;
   EEG.chanlocs(OldID).labels=EEG.chanlocs(NewID).labels;
   EEG.chanlocs(OldID).labels=EEG.chanlocs(NewID).labels;
   EEG.nbchan = EEG.nbchan - 1;
   EEG.data(OldID,:)= EEG.data(NewID,:);
   EEG.data(NewID,:)= [];
   EEG.chanlocs(NewID)=[];
end

disp(['========================================================================='])
EEG = pop_saveset(EEG, 'filename',['Channels_replaced_' filename],'filepath',filepath);
disp(['========================================================================='])
disp(cell2str(['Ok Mahesh, channel/s number: ', cell2str(chanlistOLD, ' '),' has/ve been successfully replaced by channel/s number: ' cell2str(chanlistNEW, ' ')], ' '))
display('In order to check the channels structure, double click on object: Canali')
disp(['========================================================================='])
Canali = struct2cell(EEG.chanlocs(1,:));
disp(['========================================================================='])
disp(['Done, a new file named: ' ['Channels_replaced_' filename] ' has been saved in:'])
disp (filepath);
disp(['========================================================================='])

end


