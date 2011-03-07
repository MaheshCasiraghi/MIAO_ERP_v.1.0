%function [EEGOUT] = M015_PLOT_EEG_CHANSPECTRA(EEG, continuus)
function [EEG] = M015_PLOT_EEG_CHANSPECTRA(EEG, type)
%function [EEGOUT] = M015_PLOT_EEG_CHANSPECTRA(EEG, conti vs. epoch)
%   M015_PLOT_ERP_CHANSPECTRA(EEG)
if type == 'conti'
 figure; pop_spectopo(EEG, 1, [EEG.xmin EEG.xmax], 'EEG' , 'percent', 50, 'freq', [7:1:20], 'freqrange',[0 60],'electrodes','off');
elseif type == 'epoch'
a = EEG.xmin*1000;
b = EEG.xmax*1000;
 figure; pop_spectopo(EEG, 1, [a b], 'EEG' , 'percent', 100, 'freq', [7:1:20], 'freqrange',[0 60],'electrodes','off');
end
end

