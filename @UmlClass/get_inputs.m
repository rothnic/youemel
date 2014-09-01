function [ inputs_str ] = get_inputs( meth )
%GET_INPUTS - One line description of what the function or script performs (H1 line)
%   GET_INPUTS has a second line of description that can go on to additional
%   lines if needed, for a more detailed description
%
% SYNTAX:
%   [ output1 ] = get_inputs( meth )
%   get_inputs( meth, 'optionalInput1', 'optionalInputValue' )
%   get_inputs( meth, 'optionalInput2', 50 )
%
% Description:
%   [ output_args ] = get_inputs( meth ) further description about 
%        the use of the function can be added here.
%
% INPUTS:
%   meth - Description
%   optionalInput1 - Description
%   optionalInput2 - Description   
%
% OUTPUTS:
%   output1 - Description
%
% EXAMPLES:
%   Line 1 of multi-line use case goes here
%   Line 2...
%
% M-FILES required: none
%
% MAT-FILES required: none
%
% SEE ALSO: OTHER_FUNCTION1, OTHER_FUNCTION2
% 
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         31-Aug-2014
% Update:

if ~isempty(meth.InputNames)
    inputs_str = strjoin(meth.InputNames', ', ');
else
    inputs_str = {''};
end

end
