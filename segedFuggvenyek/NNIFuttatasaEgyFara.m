function [jelenlegiFa, helyiNNIPontszamok, helyiNNIPontszamCsokkenesek] = NNIFuttatasaEgyFara(jelenlegiFa, tablazat, NNIPontszamokMemorizalas, NNIPontszamokCsokkenesMemorizalas)
    
    helyiNNIPontszamok = {};
    helyiNNIPontszamCsokkenesek = [];
    
    if NNIPontszamokMemorizalas
        helyiNNIPontszamok = {jelenlegiFa}; 
    end
    
    lokalisOptimumMegtalalva = false;
    
    while ~lokalisOptimumMegtalalva
        [jelenlegiFa, helyiNNIPontszamCsokkenesek, helyiNNIPontszamok, lokalisOptimumMegtalalva] = ...
            NNIEgyLepes(jelenlegiFa, tablazat, helyiNNIPontszamCsokkenesek, helyiNNIPontszamok, ...
            NNIPontszamokCsokkenesMemorizalas, NNIPontszamokMemorizalas);
    end

end
