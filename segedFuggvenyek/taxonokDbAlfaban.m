function taxonokAlfabanDb = taxonokDbAlfaban(taxonId, pointerek, levelekDb)
taxonokAlfabanDb = 0;
sor = taxonId;

while ~isempty(sor)
    jelenlegiTaxon = sor(1);
    sor(1) = [];

    if jelenlegiTaxon > levelekDb
        taxonId = jelenlegiTaxon - levelekDb;
        sor(end+1:end+2) = pointerek(taxonId, :);
    end
    taxonokAlfabanDb = taxonokAlfabanDb + 1;
end
end