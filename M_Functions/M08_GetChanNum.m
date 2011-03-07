%[ChanNumber] = M08_GetChanNum(EEG, ChannelLabel). Get the channelID, given the channelLABEL.
function [ChanNum] = M08_GetChanNum(EEG, Label)
%[ChanNumber] = M08_GetChanNum(EEG, ChannelLabel). Get the channelID, given the channelLABEL.
i=1;

while ~(strcmpi(EEG.chanlocs(i).labels,Label))
    i=i+1;
    if i > length(EEG.chanlocs)
        error ('ATTENTION: channel: %s not found.',Label)
    end
end

ChanNum=i;

end

