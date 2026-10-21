% TBR-t hajt végre egy fán, amíg el nem éri a lokális optimumot.
function [jelenlegiFa, helyiPontszamok, helyiPontszamCsokkenesek] = TBREgyFara(jelenlegiFa, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, holofiletikusOsztalyok, minimumValoszinusegJelleghez, TBRMaxProbalkozasok)

helyiPontszamok = {};
helyiPontszamCsokkenesek = [];

if pontszamokMemorizalas
    helyiPontszamok = {jelenlegiFa};
end

lokalisOptimum = false;

while ~lokalisOptimum
    [jelenlegiFa, talaltJobbat, helyiPontszamok, helyiPontszamCsokkenesek] = ...
        TBREgyLepes(jelenlegiFa, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, ...
        helyiPontszamok, helyiPontszamCsokkenesek, ...
        holofiletikusOsztalyok, minimumValoszinusegJelleghez, TBRMaxProbalkozasok);

    lokalisOptimum = ~talaltJobbat;
end
end