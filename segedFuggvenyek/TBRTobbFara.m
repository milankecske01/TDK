% TBR-t hív meg több fán, és a pontszámokat és csökkenéseket elmenti, ha akarjuk.
function [fak, Pontszamok, PontszamokCsokkenes] = TBRTobbFara(fak, beszedes, waitTimerHandle, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, holofiletikusOsztalyok, minimumValoszinusegJelleghez, TBRMaxProbalkozasok)

fakDb = length(fak);

if beszedes
    set(waitTimerHandle, 'Name', "TBR futtatása");
    waitbar(0, waitTimerHandle, sprintf("0/%d", fakDb));
    drawnow;
    D = parallel.pool.DataQueue;
    afterEach(D, @(~) waitBarUpdate(waitTimerHandle, fakDb));
end

Pontszamok = cell(1, fakDb);
PontszamokCsokkenes = cell(1, fakDb);

parfor i = 1:fakDb
    [optimalizaltFa, helyiPontszamok, helyiPontszamCsokkenesek] = ...
        TBREgyFara(fak(i), pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, ...
        holofiletikusOsztalyok, minimumValoszinusegJelleghez, TBRMaxProbalkozasok);

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