%[EEG, art] = M028_RunADJUST_SavePlots(EEG, 'C:\SETs\sj01_Adjust_Report.txt');
function [EEG,art] = M028_RunADJUST_SavePlots(EEG, reportfile, filepath)
%[EEG] = M028_RunADJUST_SavePlots(EEG, 'C:\SETs\sj01_Adjust_Report.txt');
[art, horiz, vert, blink, disc, soglia_DV, diff_var, soglia_K, meanK, soglia_SED, SED, soglia_SAD, SAD, soglia_GDSF, GDSF, soglia_V, nuovaV, soglia_D, maxdin]= ADJUST(EEG, reportfile);
%[EEG, art] = M028_RunADJUST_SavePlots(EEG, 'C:\SETs\sj01_Adjust_Report.txt');
for i = 1:numel(art);
p=art(i);
pop_prop(EEG, 0, p, NaN, {'freqrange' [0.1 60] });
saveas(gcf, [filepath 'Fig_' EEG.setname '_RejectedComp_' mat2str(p) '_prop.fig']);
close(gcf);
figure; pop_headplot(EEG, 0, p, '', [1  1], 'load','C:\\Users\\Mahesh Casiraghi\\Documents\\MATLAB\\My_Functions\\3Dsplinefile.spl');
saveas(gcf, [filepath 'Fig_' EEG.setname '_RejectedComp_' mat2str(p) '_3Dmap.fig']);
close(gcf);
end
p = size(EEG.icaact,1);
[EEG,com] = pop_selectcomps_ADJ( EEG, [1:p], art, horiz, vert, blink, disc, soglia_DV, diff_var, soglia_K, meanK, soglia_SED, SED, soglia_SAD, SAD, soglia_GDSF, GDSF, soglia_V, nuovaV, soglia_D, maxdin);
saveas(gcf, [filepath 'Fig_' EEG.setname '_TotalComponents_B.fig']);
close(gcf);
saveas(gcf, [filepath 'Fig_' EEG.setname '_TotalComponents_A.fig']);
close(gcf);
fprintf('.......................................................\n')
fprintf(['Full Figure and Properties and 3D maps of Single Rejected Components have been saved.\n']);
fprintf('.......................................................\n')
end

