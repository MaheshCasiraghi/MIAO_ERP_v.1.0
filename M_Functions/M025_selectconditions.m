%[EEG] = M025_selectconditions(EEG, 16, 'sj01_epochs_', 'C:\\SETs\\sj01_binsets\\')
function [EEG] = M025_selectconditions(EEG, binnumber, filename, folder)
%[EEG] = M025_selectconditions(EEG, 16, 'sj01_epochs_', 'C:\\SETs\\sj01_binsets\\')
markmat = M05_InfoMarkers(EEG);
for t = 1:binnumber
p = strfind((markmat(:,2)), ['B' num2str(t) '(']);
pippo(binnumber)={[0]};
pippo(t) = {[filename 'BIN_' num2str(t) '.set']};
B1eventarray = {};
l = 1;
i = 0;
for i = 1:length(p);
if isequal(p(i),{[]}) == 0
B1eventarray(l) = [markmat(i,2)];
l=l+1;
end
end
[EEG1] = pop_selectevent(EEG, 'type',B1eventarray,'deleteevents','off','deleteepochs','on','invertepochs','off');
EEG1.icaact = [];
EEG1.icawinv = [];
EEG1.icasphere = [];
EEG1.icaweights= [];
EEG1.icachansind = [];
EEG1.setname = cell2str(pippo(t));
[EEG1] = pop_saveset (EEG1, 'filename', cell2str(pippo(t)),'filepath', folder);
fprintf('.......................................................\n');
fprintf(['Dataset ' cell2str(pippo(t)) ' has been saved in ' folder '.\n'])
fprintf(['It contains just all the epochs timelocked to the following Events: \n'])
fprintf([cell2str(B1eventarray) '\n'])
fprintf('.......................................................\n');
end
end
