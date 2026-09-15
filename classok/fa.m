classdef fa
    properties
        szerkezet phytree
        fitchTavolsag double = 0
        valodiTavolsag double = 0
        tablazat table
    end
    
    methods
        function obj = fa(szerkezet, tablazat)
            % Check if arguments were provided
            if nargin > 0
                obj.szerkezet = szerkezet;
                obj.tablazat = tablazat;
            end
        end
    end
end