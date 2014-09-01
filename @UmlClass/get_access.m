function [ access_str ] = get_access( prop )
%GET_ACCESS - returns the access string for the access type of the prop
%
% SYNTAX:
%   [ access_str ] = get_access( prop )
%
% Description:
%   [ access_str ] = get_access( prop ) returns the access string for the
%   access type of the given prop object
%
% INPUTS:
%   prop - prop object obtained from metaclass   
%
% OUTPUTS:
%   access_str - the UML symbol for the prop access
%
% EXAMPLES:
%
% SEE ALSO: UmlClass
% 
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         31-Aug-2014

try
    access_type = prop.Access;
catch
    access_type = prop.GetAccess;
end

switch access_type
    case 'public'
        access_str = '+';
    case 'private'
        access_str = '-';
    case 'protected'
        access_str = '#';
end

end
