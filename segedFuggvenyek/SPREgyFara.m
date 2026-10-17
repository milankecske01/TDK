% SPR-t hajt végre egy fán, amíg el nem éri a lokális optimumot.
% Folyamatosan hívja az 'SPREgyLepes' függvényt, amíg az talál jobb fát.
function [jelenlegiFa, helyiPontszamok, helyiPontszamCsokkenesek] = SPREgyFara(jelenlegiFa, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas)
    
    helyiPontszamok = {};
    helyiPontszamCsokkenesek = [];
    
    if pontszamokMemorizalas
        helyiPontszamok = {jelenlegiFa};
    end
    
    lokalisOptimum = false;
    
    while ~lokalisOptimum
        [jelenlegiFa, talaltJobbat, helyiPontszamok, helyiPontszamCsokkenesek] = ...
            SPREgyLepes(jelenlegiFa, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, helyiPontszamok, helyiPontszamCsokkenesek);
        
        lokalisOptimum = ~talaltJobbat;
    end
end