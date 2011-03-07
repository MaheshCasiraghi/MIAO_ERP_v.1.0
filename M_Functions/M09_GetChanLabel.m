%[ChanLabel] = M09_GetChanLabel(EEG, ChannelNumber). Get the channeLabel, given the channelID.
function [ChanLabel] = M09_GetChanLabel(EEG, Number)
%[ChanLabel] = M09_GetChanLabel(EEG, ChannelNumber). Get the channeLabel, given the channelID.
i=1;

while ~(strcmpi(num2str(EEG.chanlocs(i).urchan),(num2str(Number))))
    i=i+1;
    if i > length(EEG.chanlocs)
        error ('ATTENTION: channel: %s not found.',Number)
    end
end

ChanLabel=EEG.chanlocs(i).labels;

end

