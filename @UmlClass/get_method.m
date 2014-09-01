function [ meth_str ] = get_method( meth )
%GET_METHOD - One line description of what the function or script performs (H1 line)
%   GET_METHOD has a second line of description that can go on to additional
%   lines if needed, for a more detailed description
%
% SYNTAX:
%   [ output1 ] = get_method( meth )
%   get_method( meth, 'optionalInput1', 'optionalInputValue' )
%   get_method( meth, 'optionalInput2', 50 )
%
% Description:
%   [ output_args ] = get_method( meth ) further description about 
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

access_sym = UmlClass.get_access(meth);

inputs_str = UmlClass.get_inputs(meth);

meth_str = strcat(access_sym, [' ', meth.Name], ...
    '(', inputs_str, ')');
      
end
