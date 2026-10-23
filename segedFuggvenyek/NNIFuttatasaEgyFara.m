function [jelenlegiFa, helyiNNIPontszamok, helyiNNIPontszamCsokkenesek] = NNIFuttatasaEgyFara(jelenlegiFa, tablazat, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, holofiletikusOsztalyok, minimumValoszinusegJelleghez)
    
    helyiNNIPontszamok = {};
    helyiNNIPontszamCsokkenesek = [];
    
    if pontszamokMemorizalas
        helyiNNIPontszamok = {jelenlegiFa}; 
    end
    
    lokalisOptimumMegtalalva = false;
    
    while ~lokalisOptimumMegtalalva
        [jelenlegiFa, helyiNNIPontszamCsokkenesek, helyiNNIPontszamok, lokalisOptimumMegtalalva] = ...
            NNIEgyLepes(jelenlegiFa, tablazat, helyiNNIPontszamCsokkenesek, helyiNNIPontszamok, ...
            pontszamokCsokkenesMemorizalas, pontszamokMemorizalas, holofiletikusOsztalyok, minimumValoszinusegJelleghez);
    end
end