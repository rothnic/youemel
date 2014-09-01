function add_method( self, meth )
%ADD_METHOD - One line description of what the function or script performs (H1 line)
%   ADD_METHOD has a second line of description that can go on to additional
%   lines if needed, for a more detailed description
%
% SYNTAX:
%   [ output1 ] = add_method( orig_str )
%   add_method( orig_str, 'optionalInput1', 'optionalInputValue' )
%   add_method( orig_str, 'optionalInput2', 50 )
%
% Description:
%   [ output_args ] = add_method( orig_str ) further description about 
%        the use of the function can be added here.
%
% INPUTS:
%   orig_str - Description
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

%% Process the method string

if strcmp(meth.DefiningClass.Name, self.class_name) && ... % ignore inherited
        ~strcmp(meth.Name, self.class_name) && ...         % ignore constructor
        ~strcmp(meth.Name, 'empty')                 % ingore empty
    
    meth_str = UmlClass.get_method(meth);
else
    meth_str = {};
end

%% Add the string to the dot string if this class defines it
if ~isempty(meth_str)
    self.add_text(meth_str, meth);
end

end
