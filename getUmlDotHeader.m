function [ header ] = getUmlDotHeader( dia_name )
%GETUMLDOTHEADER - create a dotviz header for a UML diagram
%
% SYNTAX:
%   [ output1 ] = getUmlDotHeader( dia_name )
%
% Description:
%   [ output_args ] = getUmlDotHeader( dia_name ) returns the dotviz header
%   for a uml diagram, given the diagram name as a string
%
% INPUTS:
%   dia_name - diagram name   
%
% OUTPUTS:
%   header - dotviz uml diagram header
%
% EXAMPLES:
%
% SEE ALSO: dotStringFromClass
% 
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         29-Aug-2014

header = {};
font = 'Bitstream Vera Sans';
font_size = 8;

%% Diagraph opening
header{1} = strcat('digraph', [' ', dia_name], '{');
header{2} = strcat('fontname = ', '"', font, '"');
header{3} = strcat('fontsize = ', num2str(font_size));
header{4} = 'rankdir = BT';

%% Node Style
header{5} = 'node [';
header{6} = strcat('fontname = ', '"', font, '"');
header{7} = strcat('fontsize = ', num2str(font_size));
header{8} = 'shape = "record"';
header{9} = ']';

%% Edge Style
header{10} = 'edge [';
header{11} = 'arrowhead = "empty"';
header{12} = ']';

%% 
end
