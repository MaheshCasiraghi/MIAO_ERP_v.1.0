% [EEG Canali] = M03_Deletechannel (EEG, 66:69). Romove one or more channels from the EEG Dataset.                                       
 
function [EEG Canali] = M03_DeleteChannel(EEG, number)
%M03_DELETECHANNEL Summary of this function goes here
%   Detailed explanation goes here
EEG.nbchan = EEG.nbchan - length(number);
EEG.data(number,:)= [];
EEG.chanlocs(number)=[];
disp(['========================================================================='])
display(['Ok Mahesh, channel/s number: ',num2str(number),' has/ve been successfully removed from the following dataset: ', num2str(EEG.filename)])
display('In order to check the channels structure, double click on object: Canali')
disp(['========================================================================='])
Canali = struct2cell(EEG.chanlocs(1,:));
end

