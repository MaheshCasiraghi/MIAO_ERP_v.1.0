function [OUTEEG] = M014_PLOT_ERP_CHANPROP(EEG, channumber)
%M014_PLOT_EEG_CHANPROP(EEG, [1:68])
%   Detailed explanation goes here

pop_prop( EEG, 1, channumber(1), NaN, {'freqrange' [0 30] });
% pop_prop( EEG, 1, channumber(2), NaN, {'freqrange' [0 30] });
% pop_prop( EEG, 1, channumber(3), NaN, {'freqrange' [0 30] });
% pop_prop( EEG, 1, channumber(4), NaN, {'freqrange' [0 30] });
% pop_prop( EEG, 1, channumber(5), NaN, {'freqrange' [0 30] });
% pop_prop( EEG, 1, channumber(6), NaN, {'freqrange' [0 30] });
for i=1:(length(channumber)-1)
    pop_prop( EEG, 1, channumber(1+i), NaN, {'freqrange' [0 30] });
end 
end

