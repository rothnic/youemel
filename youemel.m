function [ output1 ] = youemel( root_path, varargin )
%YOUEMEL - One line description of what the function or script performs (H1 line)
%   YOUEMEL has a second line of description that can go on to additional
%   lines if needed, for a more detailed description
%
% SYNTAX:
%   [ output1 ] = youemel( root_path )
%   youemel( root_path, 'optionalInput1', 'optionalInputValue' )
%   youemel( root_path, 'optionalInput2', 50 )
%
% Description:
%   [ output_args ] = youemel( root_path ) further description about
%        the use of the function can be added here.
%
% INPUTS:
%   root_path - Description
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
% Date:         29-Aug-2014
% Update:

%% Input Parsing
% Setup input parsing
p = inputParser;
p.FunctionName = 'youemel';
p.addRequired('root_path');
p.parse(root_path, varargin{:});

% Assign function variables
root_path = p.Results.root_path;
paths = rdir([root_path, '\**']);
%% Primary function logic begins here

header = getUmlDotHeader( 'none' );
footer = '}';

all_cls_str = {};
all_rel_str = {};

for i = 1:length(paths)
    files = what(paths(i).name);
    files = files.m;
    files = strrep(files, '.m', '');
    
    for j = 1:length(files)
        
        mclass = meta.class.fromName(files{j});
        if ~isempty(mclass)
            [ cls_str, rel_str ] = dotStringFromClass( mclass );
            all_cls_str = horzcat(all_cls_str, cls_str);
            all_rel_str = horzcat(all_rel_str, rel_str);
        end
    end
end

all_cls_str = unique(all_cls_str);
all_rel_str = unique(all_rel_str);
dot_str = horzcat(header, all_cls_str, all_rel_str, footer);

fileid = fopen('dotfile.dot', 'w');
for i = 1:length(dot_str)
    
    fprintf(fileid, strcat(dot_str{i}, '\n'));
end

fclose(fileid);
end
