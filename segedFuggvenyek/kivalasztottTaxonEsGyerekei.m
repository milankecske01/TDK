% megkapja egy fának a pointers mátrixát, majd egy megadott id-jű taxont
% és összes gyerekét visszaadja.
function taxonok = kivalasztottTaxonEsGyerekei(P, taxonId)
    levelekDb = size(P,1)+1;
    
    
    taxonok = [];
    verem = taxonId;
    
    while ~isempty(verem)
        aktualis = verem(end);
        verem(end) = []; 
    
        taxonok(end+1) = aktualis; 
    
        if aktualis > levelekDb
            gyerekek = P(aktualis - levelekDb, :);
    
            verem = [verem, gyerekek(1), gyerekek(2)];
        end
        end
end