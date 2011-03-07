%[ERP] = M027_SplitChan_ERLs(ERP, 28)
function [ERP] = M027_SplitChan_ERLs(ERP, channumb)
%[ERP] = M027_SplitChan_ERLs(ERP, number fo channels)
for i = 1:channumb;
argument = [' chan' num2str((channumb+i)) ' = chan' num2str(i)];
ERP = pop_erpchanoperator(ERP, {argument});
end
ERP.chanlocs = readlocs('C:\\Users\\Mahesh Casiraghi\\Documents\\MATLAB\\My_Functions\\Split_ERL_chans.elp','filetype', 'besa');
fprintf('.......................................................\n')
fprintf(['The ' num2str(channumb) ' channels have been successfully splitted into left and right channels.\n']);
fprintf('.......................................................\n')
end

