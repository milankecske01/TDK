% visszadja egy taxon összes levél gyerekét (indexeket) egy fában.
function levelIdk = levelekAlfaban(pointerek, taxonId)

    levelIdk = [];
    sor = taxonId;
    
    while ~isempty(sor)
        jelenlegiTaxon = sor(1);
        sor(1) = [];
    
        if jelenlegiTaxon > levelekDb
            taxonId = jelenlegiTaxon - levelekDb;
            sor(end+1:end+2) = pointerek(taxonId, :);
        else
            levelIdk(end+1)=jelenlegiTaxon;
        end
    end
end