% Usage: strvec = vect2colon(vec, options)
%
% Converts a vector into a string with its MATLAB colon notation (single resolution).
%
% Options are:
% 
% 'DelimiterEnable'   -   'yes'/'no'    Including or not square brackets []
%                                       'yes' by default.
% 'Sort'              -   'yes'/'no'    yes: Sort elements in ascending order
%                                       no : display as it is ( but repeated elements ) 
%                                       'no' by default
%
% MATLAB colon notation is a compact way to refer to ranges of matrix elements.
% It is often used in copy operations and in the creation of vectors and matrices.
% 
% Colon notation can be used to create a vector as follows
% 
% >> x = xbegin:dx:xend
% 
% or
% 
% >> x2 = xbegin:xend
% 
% where xbegin and xend are the range of values covered by elements of the x 
% vector, and dx is the (optional) increment. If dx is omitted a value of 1 
% (unit increment) is used. The numbers xbegin, dx, and xend need not be 
% integers.
%
%
% Example 1:
%
% >> x = [ 2 3 4 5 6 10 20 30 40 50 1000 1100 1200];
% >> vect2colon(x)
%
% ans =
%
% [ 2:6 10:10:50 1000:100:1200]
%
% Example 2:
%
% >> x = [ 2 3 4 5 6 10 10.1 10.2 10.3 10.4 1000 1100 1200]
% >> s = vect2colon(x)
%
% s =
% 
% [ 2:6 10:0.1:10.4 1000:100:1200 ]
%
% Example 3:
%
% >> x = [ 2 3 4 5 6 10 1000 1100 1200 10.1 10.2 10.3 10.4]
% >> s = vect2colon(x, 'DelimiterEnable', 'no')
%
% s =
%
%  2:6 10 1000:100:1200 10.1:0.1:10.4
%
%
%
% See also:  eval, str2num
%
% Author: Javier Lopez-Calderon
% 2008
%
% Feedbacks are appreciated.
%
% P1:Bug, two elements appeared without square brackets ([]). 
% R1:Fixed  11/29/2008, JLC
% Include options. 12/09/2008,  JLC

function strvec = vect2colon(vec, varargin)

p = inputParser;
p.FunctionName  = mfilename;
p.CaseSensitive = false;
p.addRequired('vec', @isvector);
p.addParamValue('DelimiterEnable', 'yes', @ischar);
p.addParamValue('Sort', 'no', @ischar);
p.parse(vec, varargin{:});

strvec   = '';
if nargin<1
    help vect2colon
    return
end

[dime] = size(vec);

if length(dime)>2
    disp('Error: vect2colon only works for row or column vector')
    return
else
    if dime(1)>=1 && dime(2)==1
        apo = '''';
    elseif dime(1)==1 && dime(2)>=1
        apo = '';
    else
        disp('Error: vect2colon only works for row or column vector')
        return

    end
end

if strcmpi(p.Results.Sort,'yes')
    vecuni      = unique(vec);    % repeated numbers are not allowed...sorted
else
    [v a b] = unique(vec', 'first');
    ia = sort(a);
    vecuni = vec(ia); % repeated numbers are not allowed...original sorting
end

dvec     = single(diff(vecuni));
holdc    = 0;
iexpress = 0;
k = 1;

while k <= numel(vecuni)
    if k>1 && k <= numel(vecuni) - 1
        if dvec(k) == dvec(k-1) && ~holdc
            holdc = 1;
            iexpress = iexpress + 1; % group counter
            if abs(dvec(k)) ~= 1
                if dvec(k)==single(pi)
                    dvstr = 'pi'; % luxe
                else
                    dvstr = num2str(dvec(k));
                end
                strvec = [ strvec ':' dvstr ':' ];     % starts a group with step>1
            else
                strvec = [ strvec ':' ];               % starts a group with step=1
            end
        elseif dvec(k) ~= dvec(k-1) && ~holdc
            strvec = [ strvec ' ' num2str(vecuni(k)) ];   % discret element
            iexpress = iexpress + 1;
        elseif dvec(k) ~= dvec(k-1) && holdc
            strvec = [ strvec num2str(vecuni(k)) ];       % ends a group with step=1
            iexpress = iexpress + 1;
            holdc = 0;
            dvec(k) = 0; % since repeated numbers are not allowed...
        end
    else
        if holdc
            strvec = [ strvec num2str(vecuni(k)) ];      % last element
        else
            strvec = [ strvec ' ' num2str(vecuni(k)) ];  % first(last) element (discrete)
            iexpress = iexpress + 1;
        end
    end
    k = k + 1;
end


if ((iexpress-1)>1 || ((iexpress-1)==1 && numel(vecuni)==2))...
        && strcmp(p.Results.DelimiterEnable,'yes')
   
        strvec = [ '[' strvec ']' apo];
end

