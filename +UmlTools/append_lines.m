function [ cell_str ] = append_lines( cell_str, str )
%APPEND_LINES adds the provided text to the end of a cell array
%
% SYNTAX:
%   [ cell_str ] = append_lines( cell_str, str )
%
% Description:
%   [ cell_str ] = append_lines( cell_str, str ) further description about 
%        the use of the function can be added here.
%
% INPUTS:
%   cell_str
%   str  
%
% OUTPUTS:
%   cell_str - Description
%
% EXAMPLES:
%
% SEE ALSO: 
% 
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         31-Aug-2014

% Make sure we always work with cell_str
if ischar(str)
    str = cellstr(str);
elseif ~iscellstr(str)
    str = {str};
end

% Loop through and add each str to cell_str
for i = 1:length(str)
    cell_str{length(cell_str) + 1} = str{i};
end

end
