%[EEG EEG1] = M018_COMPARE_FILTERED_EEGs(EEG, [1:68], 0.1, 30, 6)
function [EEG EEG1] = M018_COMPARE_FILTERED_EEGs(EEG, chans, lowcut, hicut, order)
%M018_COMPARE_FILTERED_EEGS Summary of this function goes here
EEG1 = EEG;
EEG = pop_basicfilter(EEG, chans, 0.1, 0, order, 'butter', 1, []);
EEG1 = pop_basicfilter(EEG1, chans, 0.1, 0, order, 'butter', 1, []);
EEG = pop_basicfilter(EEG, chans, lowcut, hicut, order, 'butter', 1, []);
eegplot(EEG.data, 'data2', EEG1.data, 'dispchans', 3, 'winlength', 10, 'events', EEG.event, 'eloc_file', EEG.chanlocs)
end

