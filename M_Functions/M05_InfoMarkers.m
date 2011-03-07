% [markmat] = M05_InfoMarkers(EEG). Creates a markmat cell structure object with markers' information.
function [markmat] = M05_InfoMarkers(EEG)
%[markmat] = M05_InfoMarkers(EEG). Creates a markmat cell structure object with markers' information.
if ischar(EEG.event(1).type) == 1;
TotalMarkers={EEG.event.type};
numerico=0;
else
TotalMarkers={EEG.event.type};
for i=1:length(TotalMarkers);
EEG.event(i).type=num2str(EEG.event(i).type);
end
TotalMarkers={EEG.event.type};
numerico=1;
end
[a,b,c]=unique(TotalMarkers);
counts=histc(c,1:length(a));
[frequency,order]=sort(counts,'descend');
asorted=a(order);
frequencies=num2cell(frequency);
percentages=num2str(100*frequency/sum(frequency), '%8.3g');
percentage=str2num(percentages);
percent=num2cell(percentage);
ordinal=sort(order, 'ascend');
ordine=num2cell(ordinal);
datitrasp=[ordine;asorted;frequencies;percent];
dati=datitrasp';
intestazione={'ID' 'Marker' 'Frequency' '% Frequency'};
coda={'TOTAL:' [num2str(length(a)) ' markers'] [num2str(length(TotalMarkers)) ' events'] [num2str(100) ' percent']};
markmat=vertcat(intestazione,dati,coda);
disp(['========================================================================='])
if numerico == 1
for i=1:length(TotalMarkers)
EEG.event(i).type=str2num(EEG.event(i).type);
end
end
end
