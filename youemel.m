function youemel( root_path, varargin )
%YOUEMEL - saves a graphviz representation of the provided path of classes
%
% SYNTAX:
%   youemel( root_path )
%
% Description:
%   youemel( root_path ) saves graphviz representation of classes to
%   dotfile.dot
%
% INPUTS:
%   root_path - directory path where you have classes, which will be
%   recursively searched
%
% OUTPUTS:
%
% EXAMPLES:
%   youemel('C:\Users\nickroth\workspace\mAware\aware')
%
% SEE ALSO: RDIR, UmlDiagram, UmlClass
%
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         29-Aug-2014

%% Input Parsing
% Setup input parsing
p = inputParser;
p.FunctionName = 'youemel';
p.addRequired('root_path');
p.parse(root_path, varargin{:});

% Assign function variables
root_path = p.Results.root_path;

%% Get the UML Diagram
uml = UmlDiagram(root_path);
dot_str = uml.dot_str();

fileid = fopen('dotfile.dot', 'w');
for i = 1:length(uml.dot_str)
    
    fprintf(fileid, strcat(dot_str{i}, '\n'));
end

fclose(fileid);
end
