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


function [jelenlegiFa, helyiNNIPontszamCsokkenesek, helyiNNIPontszamok, lokalisOptimumMegtalalva] = NNIEgyLepes(jelenlegiFa, tablazat, helyiNNIPontszamCsokkenesek, helyiNNIPontszamok, NNIPontszamokCsokkenesMemorizalas, NNIPontszamokMemorizalas)

    lokalisOptimumMegtalalva = false;
    legjobbHossz = jelenlegiFa.fitchHossz;
    legjobbHosszId = -1;
    
    szomszedok = legkozelebbiSzomszedok(jelenlegiFa.szerkezet);
    szomszedokDb = length(szomszedok);
    
    for j = 1:szomszedokDb
        hossz = Fitch(get(szomszedok{j}, 'Pointers'), tablazat);
        if hossz < legjobbHossz
            legjobbHossz = hossz;
            legjobbHosszId = j;
        end
    end
    
    if legjobbHosszId == -1
        lokalisOptimumMegtalalva = true;
        return; 
    end
    
    if NNIPontszamokCsokkenesMemorizalas
        helyiNNIPontszamCsokkenesek(end+1) = jelenlegiFa.fitchHossz - legjobbHossz;
    end
    
    jelenlegiFa.szerkezet = szomszedok{legjobbHosszId};
    jelenlegiFa.fitchHossz = legjobbHossz;
    
    if NNIPontszamokMemorizalas
        helyiNNIPontszamok{end+1} = jelenlegiFa; 
    end
end