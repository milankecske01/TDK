% Végignézi az aktuális fa SPR szomszédságát. 
function [fa, talaltJobbat, helyiPontszamok, helyiPontszamCsokkenesek] = SPREgyLepes(fa, pontszamokMemorizalas, pontszamokCsokkenesMemorizalas, helyiPontszamok, helyiPontszamCsokkenesek, holofiletikusOsztalyok, minimumValoszinusegJelleghez, SPRMaxProbalkozasok)
    
    talaltJobbat = false;
    
    tablazat = fa.tablazat;
    levelekDb = get(fa.szerkezet, "NumLeaves");
    levelNevek = get(fa.szerkezet, "LeafNames"); 
    taxonokDb = get(fa.szerkezet, "NumNodes");
    pointerek = get(fa.szerkezet, "Pointers");
    faHossz = fa.fitchHossz;
    
    vaghatoTaxonok = 1:taxonokDb-1; 
    osszesVisszakotesiHely = 1:taxonokDb; 
    
    % keverjük az indexeket, hogy ne mindig a levelektől kezdjünk
    kevertVagasiIndexek = randperm(length(vaghatoTaxonok));
    probakSzama=0;
    for i = 1:length(kevertVagasiIndexek)
        levagottEl = vaghatoTaxonok(kevertVagasiIndexek(i));
        
        tiltottHelyek = kivalasztottTaxonEsGyerekei(pointerek, levagottEl);
        visszakotesiPontok = setdiff(osszesVisszakotesiHely, tiltottHelyek);
        
        kevertVisszakotesiIndexek = randperm(length(visszakotesiPontok));
        for j = 1:length(kevertVisszakotesiIndexek)
            visszakotesiPont = visszakotesiPontok(kevertVisszakotesiIndexek(j));
            
            [ujMatrix, gyoker] = SPRPointerCsere(pointerek, levagottEl, visszakotesiPont, levelekDb);
            
            if isempty(gyoker)
                gyoker = taxonokDb;
            end
            
            % Ezen a ponton elég csak a hosszt kiszámolni a gyorsításhoz
            csakLevelekAdatai = tablazat(1:levelekDb, :);
            ujFaHossz = fitchRendezetlenMatrixxal(ujMatrix, csakLevelekAdatai, gyoker);
            
            if ujFaHossz < faHossz
                csokkenes = faHossz - ujFaHossz;
                %fprintf("Jobb fa találva, hossz: %d\n", ujFaHossz);
                
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
            probakSzama=probakSzama+1;
            if probakSzama>=SPRMaxProbalkozasok;
                return;
            end
        end
    end
end