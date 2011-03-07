%[EEG] = M019_SCREEN_ALLCHAN_CONTDATA_4THR(EEG, 66, 100);
function [EEG] = M019_SCREEN_ALLCHAN_CONTDATA_4THR(EEG, channelnumber, threshold)
%[EEG] = M019_SCREEN_ALLCHAN_CONTDATA_4THR(EEG, channelnumber, threshold);
for i=1:channelnumber;
   oldnumberevent = length(EEG.event); 
   markcode = 300 + i;
EEG = pop_insertcodeonthefly(EEG, markcode, i, '>=', threshold, 600, 'normal', [], 100);
   newnumberevent = length(EEG.event); 
Chanlabel = M09_GetChanLabel(EEG, i);
inserted = newnumberevent - oldnumberevent;
fprintf('.......................................................\n')
fprintf(['CHANNEL NUMBER: ' num2str(i) ' ( ' Chanlabel ' ) has been scanned for amplitude exceeding: ' num2str(threshold) ' µV.\n'])
fprintf(['As a result: ' num2str(inserted) ' events ' num2str(markcode) ' have been created, and the dataset has now ' num2str(newnumberevent) ' events.\n'])
fprintf('.......................................................\n')
end
fprintf('.......................................................\n')
fprintf(['All the ' num2str(channelnumber) ' have been scanned for points exceeding ' num2str(threshold) ' µV.\n'])
fprintf('.......................................................\n')
end

