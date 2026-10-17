% Végignézi az aktuális fa SPR szomszédságát. 
function [fa, talaltJobbat, helyiPontszamok, helyiPontszamCsokkenesek] = SPREgyLepes(fa, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, helyiPontszamok, helyiPontszamCsokkenesek)
    
    talaltJobbat = false;
    
    tablazat = fa.tablazat;
    levelekDb = get(fa.szerkezet, "NumLeaves");
    levelNevek = get(fa.szerkezet, "LeafNames"); 
    taxonokDb = get(fa.szerkezet, "NumNodes");
    pointerek = get(fa.szerkezet, "Pointers");
    faHossz = fa.fitchHossz;
    
    vaghatoTaxonok = 1:taxonokDb-1; 
    osszesVisszakotesiHely = 1:taxonokDb; 
    
    for i = 1:length(vaghatoTaxonok)
        levagottEl = vaghatoTaxonok(i);
        
        tiltottHelyek = kivalasztottTaxonEsGyerekei(pointerek, levagottEl);
        visszakotesiPontok = setdiff(osszesVisszakotesiHely, tiltottHelyek);
        
        for j = 1:length(visszakotesiPontok)
            visszakotesiPont = visszakotesiPontok(j);
            
            [ujMatrix, gyoker] = SPRPointerCsere(pointerek, levagottEl, visszakotesiPont, levelekDb);
            
            if isempty(gyoker)
                gyoker = taxonokDb;
            end
            
            ujFaHossz = fitchRendezetlenMatrixxal(ujMatrix, tablazat, gyoker);
            
            if ujFaHossz < faHossz
                csokkenes = faHossz - ujFaHossz;
                
                ujRendezettMatrix = faRendbeRako(ujMatrix, levelekDb);
                fa.szerkezet = phytree(ujRendezettMatrix, levelNevek);
                fa.fitchHossz = ujFaHossz;
                
                if pontszamokCsokkenesMemorizalas
                    helyiPontszamCsokkenesek(end+1) = csokkenes;
                end
                
                if pontszamokMemorizalas
                    helyiPontszamok{end+1} = fa;
                end
                
                talaltJobbat = true;
                return; 
            end
        end
    end
end