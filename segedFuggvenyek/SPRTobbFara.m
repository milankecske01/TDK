% az NNI úgy működik, hogy megkeresei az összes szomszédot, majd kiválasztja a legjobbat
% ez itt nem fog működni, mert pl egy 57 leveles gyökértelen fának 11556 szomszédja van.
% ezért inkább addig keresünk, szomszédokat amíg nem találunk, majd amint
% találtunk egyet, egyből átállítjuk a fát és keresünk tovább.
% addig amíg lokális optimumban vagyunk.


% SPR-t hív meg több fán, és a pontszámokat és csökkenéseket elmenti, ha akarjuk
function [fak, Pontszamok, PontszamokCsokkenes] = SPRTobbFara(fak, beszedes, waitTimerHandle, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, holofiletikusOsztalyok, minimumValoszinusegJelleghez, SPRMaxProbalkozasok)
    
    fakDb = length(fak);
    
    if beszedes
        set(waitTimerHandle, 'Name', "SPR futtatása");
        waitbar(0, waitTimerHandle, sprintf("0/%d", fakDb));
        drawnow;
        D = parallel.pool.DataQueue;
        afterEach(D, @(~) waitBarUpdate(waitTimerHandle, fakDb));
    end
    
    Pontszamok = cell(1, fakDb);
    PontszamokCsokkenes = cell(1, fakDb);
    
    parfor i = 1:fakDb
        [optimalizaltFa, helyiPontszamok, helyiPontszamCsokkenesek] = ...
            SPREgyFara(fak(i), pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, holofiletikusOsztalyok, minimumValoszinusegJelleghez, SPRMaxProbalkozasok);
        
        fak(i) = optimalizaltFa;
        
        if pontszamokMemorizalas
            Pontszamok{i} = helyiPontszamok;
        end
        if pontszamokCsokkenesMemorizalas
            PontszamokCsokkenes{i} = helyiPontszamCsokkenesek;
        end
        
        if beszedes
            send(D, 1); 
        end
    end
    
    if beszedes
        clear waitBarUpdate;
    end
end