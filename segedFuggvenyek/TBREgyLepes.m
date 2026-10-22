% Végignézi az aktuális fa TBR szomszédságát. 
function [fa, talaltJobbat, helyiPontszamok, helyiPontszamCsokkenesek] = TBREgyLepes(fa, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, helyiPontszamok, helyiPontszamCsokkenesek, holofiletikusOsztalyok, minimumValoszinusegJelleghez, TBRMaxProbalkozasok)
    
    talaltJobbat = false;
    
    tablazat = fa.tablazat;
    levelekDb = get(fa.szerkezet, "NumLeaves");
    levelNevek = get(fa.szerkezet, "LeafNames"); 
    taxonokDb = get(fa.szerkezet, "NumNodes");
    pointerek = get(fa.szerkezet, "Pointers");
    faHossz = fa.fitchHossz;
    
    vaghatoTaxonok = 1:taxonokDb-1; 
    osszesVisszakotesiHely = 1:taxonokDb; 
    
    eredetiSzulok = szulok(fa.szerkezet);
    eredetiSzulok(isnan(eredetiSzulok)) = 0;
    
    kevertVagasiIndexek = randperm(length(vaghatoTaxonok));
    probakSzama = 0;
    
    for i = 1:length(kevertVagasiIndexek)
        levagottEl = vaghatoTaxonok(kevertVagasiIndexek(i));
        
        levagottFaTaxonok = kivalasztottTaxonEsGyerekei(pointerek, levagottEl);
        
        lebegoszulo = eredetiSzulok(levagottEl);
        
        gyerekek = pointerek(lebegoszulo - levelekDb, :);
        if gyerekek(1) == levagottEl
            levagottElTestver = gyerekek(2);
        else
            levagottElTestver = gyerekek(1);
        end
        
        tiltottHelyek = [levagottFaTaxonok(:); lebegoszulo; levagottElTestver];
        visszakotesiPontok = setdiff(osszesVisszakotesiHely, tiltottHelyek);
        
        kevertVisszakotesiIndexek = randperm(length(visszakotesiPontok));
        
        for j = 1:length(kevertVisszakotesiIndexek)
            visszakotesiPont = visszakotesiPontok(kevertVisszakotesiIndexek(j));
            
            kevertUjragyokereztetesiIndexek = randperm(length(levagottFaTaxonok));
            for k = 1:length(kevertUjragyokereztetesiIndexek)
                ujragyokereztetesiPont = levagottFaTaxonok(kevertUjragyokereztetesiIndexek(k));
                
                [ujMatrix, gyoker] = TBRPointerCsere(pointerek, eredetiSzulok, levagottEl, visszakotesiPont, ujragyokereztetesiPont, levelekDb);
                
                if isempty(gyoker) || gyoker == 0
                    gyoker = taxonokDb;
                end
                
                csakLevelekAdatai = tablazat(1:levelekDb, :);
                ujFaHossz = fitchRendezetlenMatrixxal(ujMatrix, csakLevelekAdatai, gyoker);
                
                if ujFaHossz < faHossz
                    csokkenes = faHossz - ujFaHossz;
                    %fprintf("Jobb fa találva (TBR), hossz: %d\n", ujFaHossz);
                    
                    ujRendezettMatrix = faRendbeRako(ujMatrix);
                    fa.szerkezet = phytree(ujRendezettMatrix, levelNevek);
                    fa.fitchHossz = ujFaHossz;
                    
                    fa.tablazat = elodAllapotRekonstrukcio(csakLevelekAdatai, fa.szerkezet, minimumValoszinusegJelleghez);
                    
                    if pontszamokCsokkenesMemorizalas
                        helyiPontszamCsokkenesek(end+1) = csokkenes;
                    end
                    
                    if pontszamokMemorizalas
                        fa.RI = RIEgyFara(fa);
                        fa.CI = CIEgyFara(fa);
                        fa.JHI = JHIEgyFara(fa, holofiletikusOsztalyok);
                        helyiPontszamok{end+1} = fa;
                    end
                    
                    talaltJobbat = true;
                    return;
                end
                
                probakSzama = probakSzama + 1;
                if probakSzama >= TBRMaxProbalkozasok
                    return;
                end
            end
        end
    end
end