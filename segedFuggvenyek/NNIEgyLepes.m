function [jelenlegiFa, helyiPontszamCsokkenesek, helyiPontszamok, lokalisOptimumMegtalalva] = NNIEgyLepes(jelenlegiFa, tablazat, helyiPontszamCsokkenesek, helyiPontszamok, pontszamokCsokkenesMemorizalas, pontszamokMemorizalas, holofiletikusOsztalyok, minimumValoszinusegJelleghez)
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
    
    if pontszamokCsokkenesMemorizalas
        helyiPontszamCsokkenesek(end+1) = jelenlegiFa.fitchHossz - legjobbHossz;
    end
    
    jelenlegiFa.szerkezet = szomszedok{legjobbHosszId};
    jelenlegiFa.fitchHossz = legjobbHossz;
    
    if pontszamokMemorizalas
        levelekDb = get(jelenlegiFa.szerkezet, "NumLeaves");
        csakLevelekAdatai = tablazat(1:levelekDb, :);
        
        jelenlegiFa.tablazat = elodAllapotRekonstrukcio(csakLevelekAdatai, jelenlegiFa.szerkezet, minimumValoszinusegJelleghez);
        
        jelenlegiFa.RI = RIEgyFara(jelenlegiFa);
        jelenlegiFa.CI = CIEgyFara(jelenlegiFa);
        jelenlegiFa.JHI = JHIEgyFara(jelenlegiFa, holofiletikusOsztalyok);
        
        helyiPontszamok{end+1} = jelenlegiFa; 
    end
end