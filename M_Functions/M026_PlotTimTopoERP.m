% [ERP] = M026_PlotTimTopoERP(ERP,binarray,chanarray,latencyarray)
function [ERP] = M026_PlotTimTopoERP(ERP,bin,chanarr,lowscale,upscale,latencyarray)
% [ERP] = M026_PlotTimTopoERP(ERP,'all',[1:68],[20 40 60])
if ischar(bin)
if strcmp(bin,'all') 
ciccio = ERP.bindata;
pippo = ERP.nbin;
pluto = 'ALL BINS.';
elseif ~isempty(str2num(bin));
if (str2num(bin)) <= ERP.nbin;
ciccio = ERP.bindata(:,:,str2num(bin));
pippo = numel(str2num(bin));
paperino = ERP.bindescr(str2num(bin));
pluto = [ 'BIN ' bin ', ' cell2str(paperino) '.'];
else
 msgbox(['Attention: you do not have that amount of bins in your ERP structure!']) 
return
end
else    
    msgbox(['Attention: ' bin ' is not a proper value']);
return
end
elseif ismatrix(bin)
      msgbox(['Attention: please enter your bin argument as a string: between ''''.     E.g. ''15'', not as a number: e.g. 15!']) 
return
end
	promptstr    = { 'Plotting time range (ms):', ...
			         ['Scalp map latencies (ms, NaN -> max-RMS)'], ...
					 'Plot title:' ...
			         'Scalp map options (see >> help topoplot):' };
	inistr       = { ['Filename: ' ERP.erpname '. Epoch length: ' num2str(round(ERP.xmin*1000)) '/+' num2str(round((ERP.xmax*1000))) ' milliseconds.']};
    endstr       = { ['Click on the ERP to get the scalp map at that latency, and on the 0 latency to pop out the pic.']};
    binstr       = { ['Bin Number: ' pluto ' Channels: ' vect2colon(chanarr) '.']};
   %	result       = inputdlg2( promptstr, 'ERP data and scalp maps -- pop_timtopo()', 1, inistr, 'pop_timtopo');
	
	timerange    = [ERP.xmin*1000 ERP.xmax*1000 0 0];

   
    
    if nargin < 4;
    topotime     = [NaN];
    topolabel = 'Allchans Max Amplitude';
    lowscale = 0;
    upscale = 0;
    elseif nargin >= 4 && nargin <=6;
    topotime     = [NaN];
    topolabel = 'Allchans Max Amplitude';        
else
    topotime = latencyarray;
    topolabel = mat2str(latencyarray);
end
    
    plottitle1   = cell2str(inistr);
    plottitle2   = cell2str(endstr);
    plottitle3   = cell2str(binstr);    
	scrsz = get(0,'ScreenSize');
    figure('Position',[20 40 (scrsz(3)/5)*4 (scrsz(4)/5)*4]);
	options = [0];

    
if ~isempty(ERP.chanlocs)
    if ~isfield(ERP, 'chaninfo'), ERP.chaninfo = []; end;
%	SIGTMP = reshape(ERP.bindata, size(ERP.bindata,1), ERP.pnts, ERP.nbin);
    SIGTMP = reshape(ciccio, size(ciccio,1), ERP.pnts, pippo);	
    posi = round( (timerange(1)/1000-ERP.xmin)/(ERP.xmax-ERP.xmin) * (ERP.pnts-1))+1;
	posf = round( (timerange(2)/1000-ERP.xmin)/(ERP.xmax-ERP.xmin) * (ERP.pnts-1))+1;
%	if length( options ) < 2


title({'      ';plottitle1      ;'       '; plottitle2; '     '; plottitle3 ; '     ';'     '}, 'FontName', 'Courier New', 'FontSize', 14)
    	timtopo( mean(SIGTMP(:,posi:posf,:),3), ERP.chanlocs, [timerange(1) timerange(2) lowscale upscale], topotime, ['BIN(s): ' bin '.    Channels: ' vect2colon(chanarr) '.    Latencies: ' topolabel '.'], 0, 0, 'chaninfo', ERP.chaninfo, 'plotchans', chanarr, 'electrodes', 'off', 'headrad', 0.75);
  
        
        %        com = sprintf('figure; pop_timtopo(%s, [%s], [%s], ''%s'');', inputname(1), num2str(timerange), num2str(topotime), plottitle);
%	else
%		com = sprintf('timtopo( mean(SIGTMP(:,posi:posf,:),3), EEG.chanlocs, [timerange(1) timerange(2) 0 0], topotime, '''', 0, 0, ''chaninfo'', EEG.chaninfo %s);', options);
%		eval(com)
%	    com = sprintf('figure; pop_timtopo(%s, [%s], [%s], ''%s'' %s);', inputname(1), num2str(timerange), num2str(topotime), plottitle, options);
%	end;		
else
	fprintf('Cannot make plot without channel locations\n');
	return;
end;

return

