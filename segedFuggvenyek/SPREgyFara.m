% az NNI úgy működik, hogy megkeresei az összes szomszédot, majd kiválasztja a legjobbat
% ez itt nem fog működni, mert pl egy 57 leveles gyökértelen fának 11556 szomszédja van.
% ezért inkább addig keresünk, szomszédokat amíg nem találunk, majd amint
% találtunk egyet, egyből átállítjuk a fát és keresünk tovább.
% addig amíg lokális optimumban vagyunk.


% SPR-t hajt végre egy fán,
% amíg nem talál egy jobb fát, vagy minden szomszéd fel lett kutatva.
% Amint talál egy jobbat, egyből átállítjuk a fát és keresünk tovább.
function fa = SPREgyFara(fa)
    
    lokalisOptimum = false;
    
    while ~lokalisOptimum
        
        lokalisOptimum = true;
        
        vaghatoTaxonok = vagHatoTaxonokFara(fa);
        
        for i = 1:length(vaghatoTaxonok)
            % élek helyett a taxont választjuk ki, ez azt jelenti, hogy a
            % taxon és őse közötti élt vágjuk el ilyenkor.
            jelenlegiEl = vaghatoTaxonok(i);
            
            [maradekFa, levagottReszfa] = reszFaLevagas(fa, jelenlegiEl);
            
            visszakotesiPontok = visszaKotesiPontokFara(maradekFa);
            
            for j = 1:length(visszakotesiPontok)
                celPont = visszakotesiPontok(j);
                
                ujFa = reszFaVisszakotes(maradekFa, levagottReszfa, celPont);
                
                ujFaHossz=Fitch(ujFa,fa.tablazat)

                if faJobb(ujFa, fa)
                    fa = ujFa;
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