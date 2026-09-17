classdef fa
    properties
        szerkezet phytree
        fitchHossz double = 0
        valodiHossz double = 0
        szetvalasHossz double = 0
        sulyozottHossz double = 0
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