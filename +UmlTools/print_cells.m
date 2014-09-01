function print_cells( cell_str )
%PRINT_CELLS - displays a cell array of string
%
% SYNTAX:
%   print_cells( cell_str )
%
% Description:
%   print_cells( cell_str ) further description about 
%        the use of the function can be added here.
%
% INPUTS:
%   cell_str - Description   
%
% OUTPUTS:
%   output1 - Description
%
% EXAMPLES:
%
% SEE ALSO: 
% 
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         31-Aug-2014

% loop through each cell and display it
for i = 1:length(cell_str)
    disp(cell_str{i});
end

end
