classdef UmlGeneralization < UmlDirectedRelationship
    %UMLGENERALIZATION - One line summary of this class goes here
    %
    % SYNTAX:
    %   myObject = UmlGeneralization( requiredProp )
    %
    % Description:
    %   myObject = UmlGeneralization( requiredProp ) further description about the use
    %       of the function can be added here.
    %
    % PROPERTIES:
    %   requiredProp - Description of requiredProp
    %
    % METHODS:
    %
    % EXAMPLES:
    %
    % SEE ALSO: UmlDiagram, UmlClass
    %
    % Author:       nick roth
    % email:        nick.roth@nou-systems.com
    % Matlab ver.:  8.3.0.532 (R2014a)
    % Date:         31-Aug-2014
    
    %% Properties
    properties
        general
        specific
    end
    
    %% Methods
    methods
        % UMLGENERALIZATION Constructor
        function self = UmlGeneralization(general, specific)
            self@UmlDirectedRelationship(general, specific);
            
            self.dot_modifier = ' [arrowhead = empty]';
        end
        
        function out = get.general(self)
            out = self.target();
        end
        
        function out = get.specific(self)
            out = self.source();
        end
    end

end
