% Végrehajt SPR lépést pusztán a pointerek átírásával.
% P: Rendezetlen vagy rendezett pointer mátrix
% levagasId: A levágandó taxon/részfa ID-ja (v)
% celpontId: A célpont ID-ja, ami fölé be akarjuk kötni (y)
% levelekDb: A fában lévő levelek száma
% KIMENET:
% P: A módosított pointer mátrix
% ujGyoker: Az új gyökér ID-ja (ha megváltozott), különben üres []
function [P, ujGyoker] = SPRPointerCsere(P, levagasId, celpontId, levelekDb)

    ujGyoker = [];

    levagas = levagasId;
    celpont = celpontId;
    
    [sorLevagasSzulo, oszlopLevagasSzulo] = find(P == levagas);
    if isempty(sorLevagasSzulo)
        error('A levágandó taxon a jelenlegi gyökér, ezt nem lehet levágni.');
    end
    
    levagasSzulo = sorLevagasSzulo + levelekDb;
    
    if oszlopLevagasSzulo == 1
        levagasTestvere = P(sorLevagasSzulo, 2);
    else
        levagasTestvere = P(sorLevagasSzulo, 1);
    end
    
    [sorLevagasNagySzulo, oszlopLevagasNagySzulo] = find(P == levagasSzulo);
    [sorCelpontSzulo, oszlopCelpontSzulo] = find(P == celpont);
    
    if celpontId == levagasId || celpontId == levagasTestvere || celpontId == levagasSzulo
        return; 
    end
    
    if isempty(sorLevagasNagySzulo)
        ujGyoker = levagasTestvere;
    else
        P(sorLevagasNagySzulo, oszlopLevagasNagySzulo) = levagasTestvere;
    end
    
    if isempty(sorCelpontSzulo)
        ujGyoker = levagasSzulo;
    else
        P(sorCelpontSzulo, oszlopCelpontSzulo) = levagasSzulo;
    end
    
    oszlopLevagasTestver = 3 - oszlopLevagasSzulo; 
    P(sorLevagasSzulo, oszlopLevagasTestver) = celpont;
end