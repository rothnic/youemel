classdef UmlDirectedRelationship < UmlRelationship
    %UMLDIRECTEDRELATIONSHIP - One line summary of this class goes here
    %   UMLDIRECTEDRELATIONSHIP has a first line of the description of myClass, but
    %   descriptions can include multiple lines of text if needed.
    %
    % SYNTAX:
    %   myselfect = UmlDirectedRelationship( requiredProp )
    %
    % PROPERTIES:
    %
    % METHODS:
    %
    % EXAMPLES:
    %
    % SEE ALSO: UmlGeneralization, UmlRelationship
    %
    % Author:       nick roth
    % email:        nick.roth@nou-systems.com
    % Matlab ver.:  8.3.0.532 (R2014a)
    % Date:         31-Aug-2014
    % Update:
    
    %% Properties
    properties
        target
        source
        relatedElement
    end
    
    properties
        target_arrow = '>'
        source_arrow = ' -'
        dot_modifier = ''
    end
    
    %% Methods
    methods
        % UMLDIRECTEDRELATIONSHIP Constructor
        function self = UmlDirectedRelationship(target, source)
            
            self.target = target;
            self.source = source;
        end
        
        function rel_elems = get.relatedElement(self)
            import UmlTools.*
            
            rel_elems = {};
            rel_elems = append_lines(rel_elems, self.source);
            rel_elems = append_lines(rel_elems, self.target);
        end
    end
end
