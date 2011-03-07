% Usage:  [Area AreaBefore LAT50 sampedges timedges] = M030_Get_Lat_At(ERP.bindata(26,:,33), ERP,[180 230], 'positive', 50,[150 230]);
function [Area AreaBefore LAT50 sampedges timedges] = M030_Get_Lat_At(data,ERP,latsam,polpeak,percentage,lattim)
% No documentation here beacuse it would be superficial: code and purposes
% are both clear. Note that this function is took some stuff from the areaerp()
% function of Javier Calderon.
% Mahesh Wed, March 02, 2011. [mahesh.casiraghi@gmail.com]
%% if nargin < 6 sample points rulez here: the function trusts latsam, which 
% is the window of iinterest in sample points.
% If you specify the 6th argument, it's the timewindow in ms, and the
% samplepoint window WILL BE IGNORED. 
%-----------------------------------------------------------
%Please note that in this latter case you can use the latsam argument
% (unused) to vehiculate meanings: when calling this from M031_jack,
% the latsam argument is defined to plot the permutation number(first line of title)
%03-03-2011
%--------------------------------------------------------------------------------
% Pay attention in order not to mess up here.
if nargin < 6 % sample points rulez here
lattim = '';
a = latsam(1);
b = latsam(2);
aaa = ERP.times(a);
bbb = ERP.times(b);
elseif nargin == 6  %milliseconds rulez here
if size(lattim,1) ~= 1 && size (lattim,2)~=2
msgbox(['Please fix your baseline timewindow milliseconds in something readable ([lowedge hiedge])']);
else
[distlow,indexlow]=min(abs(ERP.times-lattim(1)));
    aaa = ERP.times(indexlow);
a = indexlow;    
[disthigh,indexhigh]=min(abs(ERP.times-lattim(2)));
    bbb = ERP.times(indexhigh);
b = indexhigh;
end 
end
%% Default = 50%, put one more argument to specify the fractional cutoff frequency.   
if nargin < 5;  
percentage = 50;
end        
% I chose to not leave no open options: you SHOULD specify your arguments to 
% get it done accurately.
%% Here Luck and Co. hypersampled at 10.000Hz, to get a better precision with
% the trapz() routine (see later through this) to compute the intregral of 
% the curve.

fsn = 10000;     % new sample rate 10Khz
Tsn = 1/fsn;     % new sample period
Fk   = fsn/ERP.srate;   % oversampling factor


%% DEFINE the polarity of the peak
if polpeak == 'positive'
    signmode = 1;
elseif polpeak == 'negative'
    signmode = -1; 
else
       msgbox(['WARNING: Make up your mind and specify a correct polarity for the peak of interest! Either ''positive'' or ''negative''.']);
end

%% CONVERT the sample array at 10.000khz precision
        newsam     = linspace(a,b,Fk*(b-a+1));
%STRETCH the signal waveform in the specified window into the hypersamped
%pointarray (newsam), and flip it in case signmode = -1
        resamp     = signmode * spline(a:b, data(a:b),newsam);
%RECTIFY: THE 'below baseline' is zeroed to baseline: area 0!        
        resamp(resamp<0) = 0;
%COMPUTE THE AREA UNDER THE CURVE WITH trapz INTEGRAL 
        A = single(Tsn*trapz(resamp));
%REFLIP IN CASE IT WAS NEGATIVE      
resamprerectified = signmode * resamp; 
%% CREATE THE HYPERSAMPLED TIME ARRAY
% timehyp = (linspace(ERP.xmin,ERP.xmax,length(newsam))*1000);
% timewindowpoints = find(timehyp > aaa & timehyp < bbb); 
% timwindow_timepoints = timehyp((timewindowpoints(1)):(timewindowpoints(end)));
 %FAILURE: LEAVE THE ATTEMPT HERE FOR FUTURE USES (27-02-2011)
 
 %Second attempt on March 2, 2011:
 % Working much better, in a simpler way,  
 % batch figure plot enabled on the wave of the eagerness.
timehyp = (linspace(aaa,bbb,length(resamprerectified))); 
% It works, it was easy after all.


%% ------------------------------------------------------------------------  
% GO ON WITH THE AREA COMPUTATION LOOP
if A~=0
Ao = single(A*percentage/100);
% Inherited this loop from the ERPLAB function areaerp.
% It makes sense and I did not touch it.
                plow  = 1;
                phigh = numel(resamp);
                        while plow <= phigh
                        pmid = round((plow + phigh) / 2);
                        Ax = single(Tsn*trapz(resamp(1:pmid)));
                        if Ax > Ao
                        phigh = pmid - 1;
                        elseif Ax < Ao
                        plow = pmid + 1;
                        else
                        break     % It was found!
                        end
                        end
                
                L = pmid/Fk + a - 1;  % latency in (non-integer) samples
        else
                L=0;                  % there was not Area, so won't have a latency...
        end
        
%       LAT50 = ((L-1)/ERP.srate + ERP.xmin)*1000;
%       LAT50 = (1000*L)/ERP.srate - (ERP.xmin*ERP.srate) + 1; 
% try to play around with different formulas, finally adopting the one of Luck
% [((L-1)/ERP.srate + ERP.xmin)*1000] 02-03-2011 
%%
% Lets' not print out anything here if the value isn't found: we simpy
% print out a 0 and we'll handle it in the high order function that will
% call this one.
if L == 0
    LAT50 = 0;
else
%% Let's print out some more output here....
Area = appr(A);
AreaBefore = appr(Ao);
% This formula is taken from Luck, I played a bit with it. After some
% perplexities, I figured out it does its job.
LAT50 = ((L-1)/ERP.srate + ERP.xmin)*1000 ;
sampedges = [a b];
timedges = [aaa bbb];
%% Let's go wild here and print out some useless cool stuff just to celebrate...    
%Greenplot of Everything
figure; plot(timehyp,resamprerectified, 'g', 'LineWidth', 3);  
axis('tight');
axis 'auto y';
% If called from Jacknife[M031_JackOfDiamonds] Display the Permutation Number 
% In the title, using the Expedient of latsam (nested string) as a key. 
key = mat2str(latsam);
if isempty(str2num(key));
title({[latsam];['Peak Polarity: ' polpeak ', Total Area: ' mat2str(appr(Area)) ','];['Area before cutoff: ' mat2str(appr(Ao)) ', Latency Cutoff: ' mat2str(LAT50) ' ms'];[ 'Edges(samples): ' mat2str(sampedges) ', Edges(time): ' mat2str(round(timedges))]});
else
title({['Peak Polarity: ' polpeak ', Total Area: ' mat2str(appr(A)) ','];['Area before cutoff: ' mat2str(appr(Ao)) ', Latency Cutoff: ' mat2str(LAT50) ' ms'];[ 'Edges(samples): ' mat2str(sampedges) ', Edges(time): ' mat2str(round(timedges))]});
end
%Red vertical line of the Latency
hold on
x = LAT50;
pippo = find(timehyp < LAT50);
area(timehyp(pippo),resamprerectified(pippo),'FaceColor', [1 1 .45],'LineStyle', '-','LineWidth',3,'EdgeColor', 'g');
set(gca,'Layer','bottom')
fig_handle = gridxy(x, 'Color', 'r', 'LineWidth', 3);
%Blue horizontal line of baseline.
fig_handle = gridxy(0,0, 'Color', 'b', 'LineWidth', 3);
axcopy;
maxfigsize
%maxfigsize('restore')
% Sounds not so useless, thinking of actually implementing it in the function
% 04-03-2011
end
end
