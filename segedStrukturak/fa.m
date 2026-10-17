% homoplázia index (HI) nem lesz külön eltárolva, mert a képlete csak (1-CI)
% a HI rövidítás mindenhol a holofiletikus indexet jelenti.
classdef fa
    properties
        szerkezet phytree
        fitchHossz double = 0
        valodiHossz double = 0
        szetvalasHossz double = 0
        AQPontszam double = 0
        RI double = 0
        CI double = 0
        JHI double = 0 % súlyozott holofiletikus index
        tablazat table
    end
    
    methods
        function homoplaziaIndex = getHomoplaziaIndex(obj)
            homoplaziaIndex = 1 - obj.CI;
        end
        function RC = getRC(obj)
            RC = obj.CI*obj.RI;
        end
    end
end