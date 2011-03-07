%[EEG] = Overview(EEG)
function [EEG] = Overview(EEG)
%[EEG] = Overview(EEG)
eegplot (EEG.data, 'events', EEG.event, 'eloc_file', EEG.chanlocs, 'winlength', 400)
%   Detailed explanation goes here
end

