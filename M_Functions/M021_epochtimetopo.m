%function [EEG] = M021_epochtimetopo(EEG)
function [EEG] = M021_epochtimetopo(EEG)
%M021_TIMETOPO Summary of this function goes here
a = EEG.xmin*1000 + 20;
b = EEG.xmax*1000 - 20;
% figure; pop_timtopo(EEG, [a  b], [NaN]);
figure; pop_timtopo(EEG, [a  b], [20 40 55 95 140 230]);
%   Detailed explanation goes here
end

