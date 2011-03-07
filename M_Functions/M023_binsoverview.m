%M023_binsoverview(ERP)
function [ERP] = M023_binsoverview(ERP)
%M023_binsoverview(ERP)
figure
for i = 1:ERP.nbin;
SUBPLOT(10,10,i);
plot(ERP.times,(ERP.bindata([1:7],:,i))', 'b');
hold on
plot(ERP.times,(ERP.bindata([8:14],:,i))', 'g');
plot(ERP.times,(ERP.bindata([15:21],:,i))', 'y');
plot(ERP.times,(ERP.bindata([22:28],:,i))', 'r');
axis([round(ERP.times(1)) round(ERP.times(length(ERP.times))) -10 10]);
title(ERP.bindescr(i))
end
axcopy
end

