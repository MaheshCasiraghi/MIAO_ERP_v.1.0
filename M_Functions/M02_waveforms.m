% M02_Waveforms(EEG). Plots all the Waveforms of the EEG DataSet according to the graphic tastes of Mahesh.
function [outvar1] = M02_waveforms(EEG)
% M02_Waveforms(EEG). Plots all the Waveforms of the EEG DataSet according to the graphic tastes of Mahesh.
myeegplot(EEG.data, 'srate', EEG.srate, 'spacing', 300, 'scale', 'on', 'title', ['Continuous Waveforms: ' EEG.filename ', Mahesh Parameters'], 'dispchans', 15, 'winlength', 15, 'events', EEG.event, 'eloc_file', EEG.chanlocs, 'position', [1000 35 920 1000], 'color', {'black' [0.7 0 0.4]})
eeglab redraw
end

