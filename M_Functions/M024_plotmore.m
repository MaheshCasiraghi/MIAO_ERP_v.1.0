%M024_plot2chans(ERP, [chanarray], [bin(array)])
function [ERP] = M024_plotmore(ERP, chanarray, binarray)
%M024_plot2chans(ERP, [chanarray], [bin(array)])

scrsz = get(0,'ScreenSize');
pop_ploterps(ERP,binarray,chanarray, 'AutoYlim', 'on','Holdch', 'on', 'Axsize', [0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [1 1], 'ChLabel', 'on', 'FontSizeChan',10, 'FontSizeLeg',10, 'LegPos', 'right', 'LineWidth',3, 'Maximize', 'off', 'Position', [20 40 scrsz(3)-40 scrsz(4)-140], 'Style', 'Matlab', 'xscale', [(ERP.xmin*1000) (ERP.xmax*1000)], 'YDir', 'normal', 'yscale', [-10 10] );
  ciccio = {ERP.chanlocs(chanarray).labels};    

  SUBPLOT(1,2,1) 
%  title({['              '; '              ']; ['Bin(s) n°: ' num2str(binarray) '. (' cell2str(ERP.bindescr(binarray)) ').'];[ '         '; 'Channels: ' cell2str(ciccio) ;'           '; ] }, 'FontName', 'Courier New', 'FontSize', 12) 
 title({[ '                        ' '                      ' '                   ' '                            ' '                        '];[ '                                  ' '                      ' '                   ' '                            ' '                        ']; [ '               ' '     ' '      ' '     ' '           '];['                                                                  Bin(s) n°: ' num2str(binarray) '. (' cell2str(ERP.bindescr(binarray)) ').' ]; ['         ' '                                                                           Channels: ' cell2str(ciccio) '       ' '     ' ]; [ '       ' '          ' '         ' '          ' '           ']; [ '       ' '          ' '         ' '          ' '           '];[ '        ' '         ' '        ' '       ' '            ']}, 'FontName', 'Courier New', 'FontSize', 12) 
end

