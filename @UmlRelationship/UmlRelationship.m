classdef (Abstract) UmlRelationship < handle
    %UMLRELATIONSHIP - matlab representation of an abstract relationship
    %
    % Description:
    %   myselfect = UmlRelationship( requiredProp ) further description about the use
    %       of the function can be added here.
    %
    % PROPERTIES:
    %   requiredProp - Description of requiredProp
    %
    % SEE ALSO: UmlGeneralization
    %
    % Author:       nick roth
    % email:        nick.roth@nou-systems.com
    % Matlab ver.:  8.3.0.532 (R2014a)
    % Date:         31-Aug-2014
    
    %% Properties
    properties (Abstract)
        relatedElement
        dot_modifier
        target_arrow
        source_arrow
    end
    
    properties
        dot_str
    end
    
    methods
        function out = get.dot_str(self)
            %GET.DOT_STR returns a dot string for a general relationship.
            %The result of this method can be altered by modifying
            %target_arrow, source_arrow, or dot_modifier
            
            el1 = self.relatedElement{1};
            el2 = self.relatedElement{2};
            
            % make sure the modifier is not empty, else use empty string
            if isempty(self.dot_modifier)
                modifier = {''};
            else
                modifier = [' ', self.dot_modifier];
            end
            
            % create dot string
            out = strcat(el1.Name, self.source_arrow, self.target_arrow, ...
                [' ', el2.Name], modifier);
        end
    end
end
