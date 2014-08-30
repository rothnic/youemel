function [ cls_str, rel_str ] = dotStringFromClass( meta_class )
%DOTSTRINGFROMCLASS - Returns dot class and relationship strings
%
% SYNTAX:
%   [ cls_str, rel_str ] = dotStringFromClass( meta_class )
%
% Description:
%   [ cls_str, rel_str ] = dotStringFromClass( meta_class ) returns both
%   a cell array of classes and their relationships, represented in dot
%   notation, for a given meta_class
%
% INPUTS:
%   meta_class - Description  
%
% OUTPUTS:
%   cls_str - cell array of dot representation of the given class and any
%   classes that it inherits from
%   rel_str - cell array of relationships between the classes in cls_str
%
% EXAMPLES:
%
% SEE ALSO: youemel
% http://www.lornajane.net/posts/2011/uml-diagrams-with-graphviz
%
% Author:       nick roth
% email:        nick.roth@nou-systems.com
% Matlab ver.:  8.3.0.532 (R2014a)
% Date:         29-Aug-2014

cls_str = {};
rel_str = {};

props = meta_class.PropertyList;
meths = meta_class.MethodList;
parents = meta_class.SuperclassList;

cls_name = meta_class.Name;
newLine = '\\l';

% Create header with class name, start of label definition, class name at
% the top of the box and the initial horizontal divider
head = strcat(cls_name, '[ label = "{', cls_name, '|');

%% Create the container of properties with access attributes

prop_cont = {''};
for i = 1:length(props)
    this_prop = props(i);
    
    if strcmp(this_prop.DefiningClass.Name, cls_name)
        
        access_sym = '+';
        if this_prop.Hidden
            access_sym = '-';
        end
        
        prop_cont = strcat(prop_cont, access_sym, [' ', this_prop.Name], newLine);
    end
end

% Close out the container
prop_cont = strcat(prop_cont, '|');

%% Create the container of methods with access attributes

meth_cont = {''};
for i = 1:length(meths)
    this_meth = meths(i);
    
    if strcmp(this_meth.DefiningClass.Name, cls_name) && ... % ignore inherited
            ~strcmp(this_meth.Name, cls_name) && ...         % ignore constructor
            ~strcmp(this_meth.Name, 'empty')                 % ingore empty
        
        access_sym = '+';
        if this_meth.Hidden
            access_sym = '-';
        end
        
        if ~isempty(this_meth.InputNames)
            inputs_str = strjoin(this_meth.InputNames', ', ');
        else
            inputs_str = {''};
        end
        
        meth_cont = strcat(meth_cont, access_sym, [' ', this_meth.Name], ...
            '(', inputs_str, ')', newLine);
    end
end

tail = '}"]';

cls_str = strcat(head, prop_cont, meth_cont, tail);

%% Create relationship strings

rel_str = {};
par_classes = {};
par_relations = {};
for i = 1:length(parents)
    this_par = parents(i);
    
    this_str = strcat(cls_name, ' ->', [' ', this_par.Name]);
    
    par_meta = meta.class.fromName(this_par.Name);
    [par_cls, par_rel] = dotStringFromClass(par_meta);
    par_classes = horzcat(par_classes, par_cls);
    par_relations = horzcat(par_relations, par_rel);
    
    par_relations = horzcat(par_relations, this_str);
    
end

cls_str = horzcat(cls_str, par_classes);
rel_str = par_relations;
end
