% [JACKOUTPUT] = M031_JackOfDiamonds('GAVERAGING_Retention_ERPs_LIST.txt','H:\\BDFs\\',33,26,[150 230],'positive',50);
function [JACKOUTPUT] = M031_JackOfDiamonds(filelist, filepath, bin,channel,timewindow,peakpolarity,areapercentage)

%No documentation needed, go on through the code to check it out comment
%after comment. mahesh.casiraghi@gmail.com      Mahesh

%% DEFINE FIELDS OF THE JACKOUTPUT STRUCTURE
JACKOUTPUT.Permutation = {[]};
JACKOUTPUT.IncludedDatasets = {[]};
JACKOUTPUT.AreaTotal = {[]};
JACKOUTPUT.AreaBeforeCutOff = {[]};
JACKOUTPUT.Latency = {[]}; 
JACKOUTPUT.SampEdges = {[]}; 
JACKOUTPUT.TimeEdges = {[]}; 
JACKOUTPUT.Info = {[]};
JACKOUTPUT.WhatYouRan = {[]};
JACKOUTPUT.FigureName = {[]};
JACKOUTPUT.Info = {[]};
JACKOUTPUT.WhatYouRan = {[]};
%% LOAD THE TARGET FILELIST AND GENERATE A MAT STRUCT WITH IT.
IDgenerale = fopen([filepath filelist]);
struttura = textscan(IDgenerale, '%[^\n]','CommentStyle','#');
elenco  = cellstr(char(struttura{:}));
fclose(IDgenerale);
numero_soggetti = numel(elenco);

%% BUILD UP THE MEGA_ELENCONE STRUCT, WITH N 1:i fields, EACH ONE WITH N-i
% CELLS, EACH CELL WITH THE STRING OF THE ERP FILEPATH FOR EACH OF THE
% N-1 SUBJECTS.
for i=1:numero_soggetti;
    mega_elencone{i}=struttura{1};
    mega_elencone{i}{i}='';
    mega_elencone{i}(strcmp('',mega_elencone{i})) = [];
end
%% Load the whole bunch of ERP datasets into memory [if you are in 32bit,
% and/or you are running this routine on a crapy system, this may run into 
% problems: if you are prompted with red unintelligible nasty stuff at this 
% point, you have 2 possibilities, a) change this loop to do that serially 
% and swap out stuff from memory, or b)ask your boss for a less crapy machine.]
% You will have the ERPs structure, with all the fields: quite cool and tidy.
% TO CALL THE DIFFERENT ERPs, just type: ERPs.PERM_1(2).ERP, where you get
% the second ERPset of the first permutation. ERPs.PERM_4(6).ERP, you get
% the sixth erpset of the fourth permutation, etc etc...
%ERPs.PERM_1.ERP = struct([]); 
%eval(['ERPs.ERP_',mat2str(i),'_',mat2str(j) '= load(fullfile(cell2str(mega_elencone{i}{j})), ''-mat'');']);
%eval(['ERPs.PERM_',mat2str(i),'(',mat2str(j),')','= load(fullfile(cell2str(mega_elencone{i}{j})), ''-mat'');']);
%ERP = pop_loaderp(mega_elencone{1}, 'workspace');
%FAILURE!! Leaving it here as an omen and, cause It could be useful in order
% to easily load everything into memory, if needed. 05-03-2011.
%% SUCCESSFUL ATTEMPT 05-03-2011. BIG CYCLE: here we just run permutations,
% by permutation, and then we call back the pop_gaverager (first) and the
% M030_Get_Lat_At (after). Everything goes smooth and I think it shouldn't
% run into problems even at 32bit.. Code is pretty plane: i is the
% permutation cycle, j the subset cycle. At the end of each i (and (n-1) Js where j
% is the number of subjects), we run grandaverage(n-1) and area integralz (M030_GetLatAt). 
% then we save the figure with export_fig(much better result than saves)
% and we fill the JACKOUTPUT structure(i).fields with the correct information. 
% NOTE THAT I FINALLY EXPORTED IN .PNG. If something else (native .bmp, matlab .fig,
% .eps, or whatsoever suits your needs, feel free to update the 2 .png
% fields below with the desired format.
for i=1:(numero_soggetti);
for j=1:(numero_soggetti-1);
ERP = pop_loaderp(cell2str({mega_elencone{i}{j}}), '');
ALLERP(j)= ERP;
CURRENTERP = j;
fprintf(['Permutation number: ' mat2str(i) ', Dataset number: ' mat2str(j) ' successfully loaded into memory.\n']);
end
eval(['ERP_GAV_PERM_' mat2str(i) ' = pop_gaverager(ALLERP,[1:j], 1,1);']);
eval(['ERP_GAV_PERM_' mat2str(i) '.erpname = ERP_GAV_PERM_' mat2str(i) ';']);
[Area AreaBefore LAT50 sampedges timedges] = M030_Get_Lat_At(eval(['ERP_GAV_PERM_' mat2str(i) '.bindata(channel,:,bin)']), eval(['ERP_GAV_PERM_' mat2str(i)]), ['PERMUTATION N°' mat2str(i) ', N° of subjects: ' mat2str((numero_soggetti-1))], peakpolarity, areapercentage,timewindow);
%saveas(gcf, [filepath 'JACK_ERP_GAV_PERM_' mat2str(i) '.bmp']);
im = export_fig(gcf, [filepath 'JACK_ERP_GAV_PERM_' mat2str(i) '.png'], '-nocrop');
close(gcf);
JACKOUTPUT(i).Permutation = ['PERMUTATION N°' mat2str(i) ', N° of subjects: ' mat2str((numero_soggetti-1))];
JACKOUTPUT(i).IncludedDatasets = arg2str(mega_elencone(i));
JACKOUTPUT(i).AreaTotal = Area;
JACKOUTPUT(i).AreaBeforeCutOff = AreaBefore;
JACKOUTPUT(i).Latency = LAT50; 
JACKOUTPUT(i).SampEdges = sampedges; 
JACKOUTPUT(i).TimeEdges = timedges; 
JACKOUTPUT(i).FigureName = [[filepath 'JACK_ERP_GAV_PERM_' mat2str(i) '.png']];
JACKOUTPUT(i).Info = ['[JACKOUTPUT] = M031_JackOfDiamonds(filelist,filepath,bin,channel,timewindow,peakpolarity,areapercentage)'];
JACKOUTPUT(i).WhatYouRan = ['[JACKOUTPUT] = M031_JackOfDiamonds(' mat2str(filelist) ',' ...
    mat2str(filepath) ',' mat2str(bin) ',' mat2str(channel) ',' ...
    mat2str(timewindow) ',' mat2str(peakpolarity)  ',' mat2str(areapercentage) ')'];
clear ERP;
clear ALLERP;
CURRENTSET = 0;
end
%% We create the final montage here: we use imdisp() instead of montage()
% since a)it runs without the image processing toolbox and b)it allows for 
% single subplot editing, zoom, and whatsoever instead of pasting
% everything together indifferentiately.
imdisp({(JACKOUTPUT.FigureName)})
%dlmwrite('H:\\BDFs\\PERM1.txt',JACKOUTPUT,'');

%% We print out a JACKOUTPUT.xls ready to be read in excel, containing all
% the information from each permutation.
mega_cellone = struct2cell(JACKOUTPUT);
TITOLO_cell = fieldnames(JACKOUTPUT);
cell2csv([filepath 'JACKOUTPUT.txt'], TITOLO_cell, 'newfile')
for z=1:numero_soggetti  
cell2csv([filepath 'JACKOUTPUT.txt'], mega_cellone(:,:,z), 'appendi')
end
%% Here we print out the cool lossless .PDF. We use export_fig() to do that,
% since it indeed guarantees a quality that matlab does not reach. Problem:
% it needs ghostscript. That means you need to configure ghostscript.
% Solution: STEP1)download and install the last version of ghostscript: you can find it
% here: http://ghostscript.com/releases/. STEP2) JUST IF YOU ARE NOT RUNNING 
% THIS ON WIN64, got through ghostscript.m (in MIAO_ERP_v.1.0/Support_Functions/Exp_Fig) and
% replace gswin64c.exe with the name of your ghostscript at lines 45 and
% 61. Then run the function and a window will pop up asking you to tell her
% where the ghost script is installed. Do that, and it will work!
fprintf('------------------------------------------------------------------------------------ \n')
fprintf('JACKKNIFE ROUTINE SUCCESSFULLY RUN: SAVE YOUR MOTAGE PICTURE IN YOUR DESIRED FORMAT, \n')
fprintf('REMEMBER TO SAVE A .FIG COPY OF IT IF YOU WANT TO USE IT LATER TO PLAY AROUND!      \n')
fprintf('MOREOVER, IT HAS JUST BEEN SAVED IN A LOSSLESS .PDF IN YOUR SOURCE FOLDER.      \n')
fprintf('CHECK IT OUT THE JACKNIFE.TXT THAT HAS JUST BEEN CREATED IN IN YOUR SOURCE FOLDER!       \n')
im = export_fig(gcf, [filepath 'JACK_ERP_GAV_PERM_MONTAGE.pdf'], '-nocrop');
fprintf('------------------------------------------------------------------------------------ \n')
edit 'JACKOUTPUT.txt'
end