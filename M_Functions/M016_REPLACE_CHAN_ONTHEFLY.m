%[EEG] = M016_REPLACE_CHAN_ONTHEFLY(EEG, {'EXG6' 'EXG7' 'EXG8'}, {'P6' 'T7' 'Cz'});
function [EEG] = M016_REPLACE_CHAN_ONTHEFLY(EEG, ChanListCHANGEFROM, ChanListTOCHANGE)
%[EEG] = M016_REPLACE_CHAN_ONTHEFLY(EEG, ChanListCHANGEFROM,
%ChanListTOCHANGE);
%   Detailed explanation goes here
for i=1:length(ChanListTOCHANGE);
pippo = cell2str(ChanListTOCHANGE(i));
ChanLabelOLD = M08_GetChanNum(EEG, ChanListCHANGEFROM(i));
ChanLabelNEW = M08_GetChanNum(EEG, ChanListTOCHANGE(i));
ChanOLD = ['ch' num2str(ChanLabelOLD)];
ChanNEW = ['ch' num2str(ChanLabelNEW)];
EEG = pop_eegchanoperator(EEG, {[ChanNEW '=' ChanOLD ' label ' pippo]});
fprintf('CHANNELS HAVE BEEN SUCCESSFULLY REPLACED.\n')
fprintf('PLEASE NOTE THAT THE ORIGIN CHANNELS HAVE NOT YET BEEN DELETED!!!\n')
end
end