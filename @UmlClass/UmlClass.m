classdef UmlClass < handle
    %UMLCLASS - One line summary of this class goes here
    %   UMLCLASS has a first line of the description of myClass, but
    %   descriptions can include multiple lines of text if needed.
    %
    % SYNTAX:
    %   myselfect = UmlClass( class_name )
    %   myselfect = UmlClass( class_name, 'optionalInput1', 'optionalInputValue' )
    %   myselfect = UmlClass( requiredInput, 'optionalInput2', 50 )
    %
    % Description:
    %   myselfect = UmlClass( class_name ) further description about the use
    %       of the function can be added here.
    %
    % PROPERTIES:
    %   class_name - Description of class_name
    %   optionalProp1 - Description of optionalProp1
    %   optionalProp2 - Description of optionalProp2
    %
    % METHODS:
    %   doThis - Description of doThis
    %   doThat - Description of doThat
    %
    % EXAMPLES:
    %   Line 1 of multi-line use case goes here
    %   A class can use this area for further explaining methods.
    %
    % SEE ALSO: OTHER_CLASS1, OTHER_FUNCTION1
    %
    % Author:       nick roth
    % email:        nick.roth@nou-systems.com
    % Matlab ver.:  8.3.0.532 (R2014a)
    % Date:         31-Aug-2014
    % Update:
    
    %% Properties
    properties
        class_name
        dot_string = {}
        class_file
        relations = {}
        meta_class
    end
    
    %% Methods
    methods
        % UMLCLASS Constructor
        function self = UmlClass(class_name, varargin)
            % Setup input parsing
            p = inputParser;
            p.FunctionName = 'UmlClass';
            p.addRequired('class_name');
            p.parse(class_name, varargin{:});
            
            % Add inputs to self properties
            self.class_name = p.Results.class_name;
            self.class_file = which(strcat(self.class_name, '.m'));
            self.meta_class = meta.class.fromName(self.class_name);
            self.create_dot_string();
        end

        function create_dot_string(self)
            %CREATE_DOT_STRING builds the dot string by calling a sequence
            %of discrete class methods that could be overwritten to change
            %the formatting of the classes
            
            self.add_header();
            self.add_title();
            self.add_break();
            self.add_properties();
            self.add_break();
            self.add_methods();
            self.add_footer();
        end
        
        function add_title(self)
            %ADD_TITLE adds the class name to the dot string with link
            
            cls = findobj(self.meta_class.MethodList, 'Name', self.class_name);
            if isempty(cls)
                cls = meta.class.fromName(self.class_name);
            end
            self.add_text(cellstr(self.class_name), cls);
        end
        
        function add_header(self)
            %ADD_HEADER adds the dotviz header to the dot string
            
            header = UmlClass.get_header(self.class_name);
            self.dot_string = UmlTools.append_lines(self.dot_string, header);
        end

        function add_footer(self)
            %ADD_FOOTER adds the footer to the dot string
            
            footer = UmlClass.get_footer();
            self.dot_string = UmlTools.append_lines(self.dot_string, footer);
        end
        
        function add_methods(self)
            %ADD_METHODS adds the class methods to the dot string
            
            meths = self.meta_class.MethodList;
            
            % add each method
            for i = 1:length(meths)
                self.add_method(meths(i));
            end
        end
        
        % Add method to dot string
        new_str = add_method(self, meth)

        function add_properties(self)
            %ADD_PROPERTIES adds the class properties to the dot string
            
            props = self.meta_class.PropertyList;
            
            % add each property
            for i = 1:length(props)
                self.add_property(props(i));
            end
        end
        
        function add_property(self, prop)
            %ADD_PROPERTY adds this specific property object to the dot
            %string
            
            % add this property only if this class doesn't inherit it
            if strcmp(prop.DefiningClass.Name, self.class_name)
                prop_str = UmlClass.get_property(prop);
                self.add_text(prop_str, prop);
            end
        end
        
        function add_text(self, txt, prop, varargin)
            %ADD_TEXT adds the provided text to the end of the current dot
            %string for the class
            
            % process inputs
            p = inputParser;
            p.addRequired('txt');
            p.addOptional('url_bool', true);
            p.addParameter('force_title', false);
            p.parse(txt, varargin{:});
            
            txt = p.Results.txt;
            url_bool = p.Results.url_bool;
            force_title = p.Results.force_title;
            
            if ~iscellstr(txt)
                txt = cellstr(txt);
            end
            
            if force_title
                istitle = true;
                prop = meta.class.fromName(prop);
            else
                istitle = strcmp(prop.Name, self.class_name);
            end
            
            % process url if desired
            if url_bool
                search_txt = UmlClass.strip_access(txt);
                the_url = UmlClass.get_url(self.class_file, search_txt);
                the_url = strcat(' HREF=', the_url);
            else
                the_url = {''};
            end
            
            % replace the prop/meth string with a string wrapped in
            % required appearance types
            apps = UmlClass.get_appearance(prop, istitle);
            form_text = UmlClass.apply_appearance(prop.Name, apps);
            form_text = strrep(txt, prop.Name, form_text);
            
            % form the text as graphviz pseudo html
            form_txt = strcat('<TR><TD border="0"', the_url, '>', form_text, '</TD></TR>');
            
            % apply additional formatting based on whether the text is a
            % property/method or the class name
            if ~istitle
                form_txt = strrep(form_txt, '<TD', '<TD align="LEFT"'); 
            else
                form_txt = strrep(form_txt, strcat(form_text, '<'), ...
                    strcat('<FONT POINT-SIZE="12"', '>', form_text, ...
                    '</FONT><'));
            end
            
            form_txt = cellstr(form_txt);
            
            % add the formatted text to the end of the dot string
            self.dot_string = UmlTools.append_lines(self.dot_string, form_txt);
        end
        
        function add_break(self)
            %ADD_BREAK adds a horizontal line to the end of the current dot
            %string for the class
            
            self.dot_string = UmlTools.append_lines(self.dot_string, '<HR/>');
            self.dot_string = UmlTools.append_lines(self.dot_string, ...
                '<TR><TD border="0"></TD></TR>');
        end
        
        function print(self)
            import UmlTools.*
            print_cells(self.dot_string);
        end
    end

    %% Static Methods
    methods (Static)
        
        % Get method string
        meth_str = get_method(meth)
        
        % Get access string
        access_str = get_access(prop)
        
        % Get inputs string for method
        inputs_str = get_inputs(meth)
        
        function str = get_property(prop)
            %GET_PROPERTY gets the property string with the access type
            
            access_str = UmlClass.get_access(prop);
            str = strcat(access_str, [' ', prop.Name]);
        end
        
        function txt = strip_access(txt)
            %STRIP_ACCESS returns text of the class property that we want
            %to use as a search term
            
            txt = strrep(txt, '+', '');
            txt = strrep(txt, '-', '');
            txt = strrep(txt, '#', '');
            txt = strtrim(txt);
        end
        
        function type_str = get_appearance(prop, istitle)
            %GET_APPEARANCE returns an array of modifiers that should be
            %applied to the property
            
            type_str = {};
            
            if isprop(prop, 'Static') && prop.Static == 1
                type_str = UmlTools.append_lines(type_str, 'U');
            end
            
            if isprop(prop, 'Abstract') && prop.Abstract == 1
                type_str = UmlTools.append_lines(type_str, 'I');
            end
            
            if istitle
                type_str = UmlTools.append_lines(type_str, 'B');
            end
        end
        
        function txt = apply_appearance(txt, app_array)
            %APPLY_APPEARANCE wraps the provided text with each appearance
            %modifier in the appearance array that is provided as input
            
            % Loop over the appearances and wrap the text in each tag
            for i = 1:length(app_array)
                app_type = app_array{i};
                txt = strcat('<', app_type, '>', txt, '</', app_type, '>');
            end
        end
        
        function url_str = get_url(file_path, str_match)
            %GET_URL returns the command to navigate to the location of the
            %class element
            
            txt = fileread(file_path);
            txt_arry = strsplit(txt, '\n');
            matches = strfind(txt_arry, str_match{:});
            
            % Check to see if this is a method name we will search for
            parens = strfind(str_match, '(');

            % Process str_match as a method 
            if ~isempty(parens{1})
                
                meth_name = strsplit(str_match{:}, '(');
                meth_name = meth_name{1};
                other_file = which(strcat(meth_name, '.m'));
                
                if ~isempty(other_file)
                    % Found method in separate matlab file
                    file_path = other_file;
                    line_num = 1;
                else
                    func_matches = strfind(txt_arry, 'function');
                    non_funcs = cellfun(@isempty, func_matches);
                    matches(non_funcs) = {[]};
                    line_num = UmlClass.find_line_num(txt_arry, matches);
                end
            else
                % Process str_match as a property
                line_num = UmlClass.find_line_num(txt_arry, matches);
            end
            
            file_path = strrep(file_path, '\', '\\');
            
            % Create the string with the processed values
            url_str = strcat('"matlab: opentoline(''', file_path, ''',', ...
                [' ' num2str(line_num)], ')"');
        end
        
        function line_num = find_line_num(txt_arry, matches)
            %FIND_LINE_NUM returns the best line number for the given array
            %of strings and the associated matches. This exists to make
            %sure we choose the correct match
            
            line_num = 0;
            
            % Loop through matches and find the first line number where the
            % string occurs that is not a comment
            for i = 1:length(matches)
                if ~isempty(matches{i})
                    a_comment = is_comment(txt_arry{i}, matches{i});
                    if ~a_comment
                        line_num = i;
                        return;
                    end
                end
            end
            
            % Check if the comment character occurs before or after the
            % string we are trying to find
            function bool = is_comment(str, col_num)
                com_match = strfind(str, '%');
                if com_match < col_num
                    bool = true;
                else
                    bool = false;
                end
            end
        end
        
        function header = get_header(class_name)
            %GET_HEADER returns the header for the dot file
            
            header = {};
            header = UmlTools.append_lines(header, strcat(class_name, '['));
            header = UmlTools.append_lines(header, 'shape=none');
            header = UmlTools.append_lines(header, ...
                'label=<<TABLE CELLPADDING="0" CELLSPACING="3">');
        end
        
        function footer = get_footer()
            %GET_FOOTER returns the footer for the dot file
            
            footer = {};
            footer = UmlTools.append_lines(footer, '</TABLE>>');
            footer = UmlTools.append_lines(footer, ']');
        end
        
    end

end
