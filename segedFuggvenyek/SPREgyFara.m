% az NNI úgy működik, hogy megkeresei az összes szomszédot, majd kiválasztja a legjobbat
% ez itt nem fog működni, mert pl egy 57 leveles gyökértelen fának 11556 szomszédja van.
% ezért inkább addig keresünk, szomszédokat amíg nem találunk, majd amint
% találtunk egyet, egyből átállítjuk a fát és keresünk tovább.
% addig amíg lokális optimumban vagyunk.


% SPR-t hajt végre egy fán, amíg nem talál egy jobb fát.
% Amint talál egy jobbat, egyből átállítjuk a fát és keresünk tovább.
% Fontos, hogy ezt elődállapot rekonstrukció előtt csináljuk.
function fa = SPREgyFara(fa)
    tablazat = fa.tablazat;
    levelekDb = get(fa.szerkezet, "NumLeaves");
    levelNevek = get(fa.szerkezet, "LeafNames"); 
    
    lokalisOptimum = false;
    faHossz = fa.fitchHossz;
    
    while ~lokalisOptimum
        
        lokalisOptimum = true;
        
        taxonokDb = get(fa.szerkezet, "NumNodes");
        pointerek = get(fa.szerkezet, "Pointers");
        
        vaghatoTaxonok = 1:taxonokDb-1; 
        osszesVisszakotesiHely = 1:taxonokDb; 
        
        for i = 1:length(vaghatoTaxonok)
            levagottEl = vaghatoTaxonok(i);
            
            visszakotesiPontok = setdiff(osszesVisszakotesiHely, kivalasztottTaxonEsGyerekei(pointerek, levagottEl));
            
            for j = 1:length(visszakotesiPontok)
                visszakotesiPont = visszakotesiPontok(j);
                
                [ujMatrix, gyoker] = SPRPointerCsere(pointerek, levagottEl, visszakotesiPont, levelekDb);
                
                if isempty(gyoker)
                    gyoker = taxonokDb;
                end
                
                ujFaHossz = fitchRendezetlenMatrixxal(ujMatrix, tablazat, gyoker);
                
                if ujFaHossz < faHossz
                    ujRendezettMatrix = faRendbeRako(ujMatrix, levelekDb);
                    fa.szerkezet = phytree(ujRendezettMatrix, levelNevek);
                    
                    fa.fitchHossz = ujFaHossz;
                    faHossz = ujFaHossz;
                    
                    lokalisOptimum = false;
                    break;
                end
            end
            
            if ~lokalisOptimum
                break;
            end
        end
        
    end
end