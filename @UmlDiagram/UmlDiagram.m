classdef UmlDiagram < handle
    %UMLDIAGRAM - class representing a UmlDiagram using graphviz
    %
    % SYNTAX:
    %   myObject = UmlDiagram( root_path )
    %
    % Description:
    %   myObject = UmlDiagram( root_path ) returns a UmlDiagram object that
    %   represents a diagram of the class relationships that exist in the
    %   directory that was provided as input
    %
    % PROPERTIES:
    %   root_path
    %
    % METHODS:
    %
    % EXAMPLES:
    %
    % SEE ALSO: UmlClass
    %
    % Author:       nick roth
    % email:        nick.roth@nou-systems.com
    % Matlab ver.:  8.3.0.532 (R2014a)
    % Date:         31-Aug-2014
    
    %% Properties
    properties
        font_size = 8
        font = 'Bitstream Vera Sans'
        name = 'MatlabClassDiagram'
        draw_order = 'BT'
        shape = 'record'
        footer = '}'
        splines = 'ortho'
        dpi = 150
        
        header
        classes = {}
        relations = {}
        paths
        dot_str
    end
    
    properties (Access = private)
        digraph_opts = {}
        node_opts = {}
        edge_opts = {}
        graph_opts = {}
    end
    
    %% Methods
    methods
        % UMLDIAGRAM Constructor
        function self = UmlDiagram(root_path)
            % Setup input parsing
            
            import UmlTools.*
            
            self.paths = rdir([root_path, '\**\*.m']);
            self.add_defaults();
            self.load_classes();
            self.load_relations();
        end
        
        function str = get.dot_str(self)
            %GET.DOT_STR is a getter for the dot string of the diagram
            
            import UmlTools.*
            
            str = {};
            
            % add the header to the dot string
            str = append_lines(str, self.header);
            
            % add all class dot strings to the diagram dot string
            for i = 1:length(self.classes)
                this_class = self.classes{i};
                str = append_lines(str, this_class.dot_string);
            end
            
            % add all relationship dot strings to the diagram dot string
            for i = 1:length(self.relations)
                this_relation = self.relations{i};
                str = append_lines(str, this_relation.dot_str);                
            end
            
            % close out the diagram dot string
            str = append_lines(str, self.footer);
        end
        
        function load_classes(self)
            %LOAD_CLASSES populates the diagram classes property with a
            %cell array of Uml Class objects
            
            import UmlTools.*
            the_paths = {self.paths.name};
            dirs = cellfun(@fileparts, the_paths, 'UniformOutput', false);
            cont = cellfun(@what, dirs);
            mfiles = vertcat(cont.m);
            mfiles = unique(mfiles);
            
            % loop over each m-file that exists in the path searched
            for i = 1:length(mfiles)
                mfile = strrep(mfiles{i}, '.m', '');
                % add to classes if it is a valid class
                mclass = meta.class.fromName(mfile);
                if ~isempty(mclass)
                    self.classes = append_lines(self.classes, ...
                        UmlClass(mclass.Name));
                end
                
            end
            
        end
        
        function load_relations(self)
            %LOAD_RELATIONS populates the diagram property with a cell
            %array of Uml relationship objects
            
            import UmlTools.*
            
            % loop over classes
            for i = 1:length(self.classes)
                
                % loop over superclasses for this class
                this_class = self.classes{i};
                supers = this_class.meta_class.SuperclassList;
                for j = 1:length(supers)
                    
                    % add the relationship
                    this_super = supers(j);
                    self.relations = append_lines(self.relations, ...
                        UmlGeneralization(this_super, this_class.meta_class));
                    
                    % add the superclass if we don't have it yet
                    if ~self.is_class(this_super.Name)
                        self.classes = append_lines(self.classes, ...
                            UmlClass(this_super.Name));
                    end
                end
            end
        end
        
        %TODO: make this an array that can use findobj
        function bool = is_class(self, class_name)
            
            bool = false;
            
            for i = 1:length(self.classes)
                this_class = self.classes{i};
                
                if strcmp(this_class.class_name, class_name)
                    bool = true;
                    return;
                end
            end
        end
        
        function str = get.header(self)
            %GET.HEADER returns the header dot string for the diagram
            
            import UmlTools.*
            
            str = {};
            str = append_lines(str, strcat('digraph', [' ', self.name], ' {'));
            str = append_lines(str, self.digraph_opts);
            str = append_lines(str, 'node [');
            str = append_lines(str, self.node_opts);
            str = append_lines(str, ']');
            str = append_lines(str, 'graph [');
            str = append_lines(str, self.graph_opts);
            str = append_lines(str, ']');
            str = append_lines(str, 'edge [');
            str = append_lines(str, self.edge_opts);
            str = append_lines(str, ']');
        end
        
        function add_node_option(self, node_str)
            %ADD_NODE_OPTION appends a user defined option to the node[]
            %section of the graphviz file
            
            import UmlTools.*
            self.node_opts = append_lines(self.node_opts, node_str);
        end
        
        function add_graph_option(self, graph_str)
            %ADD_NODE_OPTION appends a user defined option to the node[]
            %section of the graphviz file
            
            import UmlTools.*
            self.graph_opts = append_lines(self.graph_opts, graph_str);
        end
        
        function add_digraph_option(self, digraph_str)
            %ADD_DIGRAPH_OPTION appends a user defined option to the
            %digraph{} section of the graphviz file
            
            import UmlTools.*
            self.digraph_opts = append_lines(self.digraph_opts, digraph_str);
        end
        
        function add_edge_option(self, edge_str)
            %ADD_EDGE_OPTION appends a user defined option to the edge[]
            %section of the graphviz file
            
            import UmlTools.*
            self.edge_opts = append_lines(self.edge_opts, edge_str);
        end
        
        function add_defaults(self)
            %ADD_DEFAULTS sets up initial options, that can be overwritten
            %if desired
            
            % setup digraph options
            self.add_digraph_option(strcat('fontname = "', self.font, '"'));
            self.add_digraph_option(strcat('fontsize = ', [' ', num2str(self.font_size)]));
            self.add_digraph_option(strcat('rankdir =', [' ', self.draw_order]));

            % setup node options
            self.add_node_option(strcat('shape = "', self.shape, '"'));
            self.add_node_option(strcat('fontsize = ', [' ', num2str(self.font_size)]));
            
            % setup graph options
            self.add_graph_option(strcat('splines =', [' ', self.splines]));
            self.add_graph_option(strcat('dpi =', [' ', num2str(self.dpi)]));
        end
        
        function print(self)
            %PRINT prints out each item in the cell array of strings as
            %separate rows, for easy viewing of the dot string
            
            import UmlTools.*
            print_cells(self.dot_str);
        end
    end

end
