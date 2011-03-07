% Usage
%
% EEG = insertcodearound(EEG, mastercode, newcode, newlate)
%
% EEG          - EEG structure (from EEGLAB)
% mastercode   - array of codes that need neighbor code(s)
% newcode      - new code(s) to insert  (new neighbor code(s))
% newlat       - latency(ies) in msec for the new code(s) to insert  (new neighbor code(s) latency(ies))
%
% Note:   mastercode, newcode, and newlate must have the same length.
%
% Example:
%
% 1)Insert a new code 78  400ms after each code 14
%
% >> EEG = insertcodearound(EEG, 14, 78, 400)
%
%
% Example:
%
% 2)Insert a new code 30  200ms before each code 120
%
% >> EEG = insertcodearound(EEG, 120, 30, -200)
%
%
% Example:
%
% 3)Insert two new codes around each code 102:
%    - a code 254 200msec earlier
%    - and a code 255 300ms later.
%
% >>EEG = insertcodearound(EEG, [102 102], [254 255], [-200 300])
%
% Author: Javier Lopez-Calderon
%         Center for Mind and Brain
%         UC Davis, January 2009

function EEG = insertcodearound(EEG, mastercode, newcode, newlate)

if nargin<1
        help insertcodearound
        return
end
if nargin>4
        disp('Error: insertcodearound needs 4 parameters ')
        return
end
nevent     = length(EEG.event);
latpnts    = round(newlate*EEG.srate/1000); %ms to sample
nguidecode =  length(mastercode);

for c=1:nguidecode
        indexcode = find(cell2mat({EEG.event.type}) == mastercode(c));
        latencies = cell2mat({EEG.event(indexcode).latency});
        ncatchcod = length(indexcode);

        [EEG.event(nevent+1:nevent+ncatchcod).type ]    = deal(newcode(c));
        newlatArray = num2cell(latencies + latpnts(c));
        [EEG.event(nevent+1:nevent+ncatchcod).latency]  = newlatArray{:};
        EEG = eeg_checkset( EEG , 'eventconsistency');
end

