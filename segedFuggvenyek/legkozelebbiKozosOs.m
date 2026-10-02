function os=legkozelebbiKozosOs(kivalasztottTaxonok,szuloIdk)

    if isempty(kivalasztottTaxonok)
        os = [];
        return;
    end

    jelenlegiTaxon=kivalasztottTaxonok(1);
    osok=jelenlegiTaxon;
    
    while isnan(szuloIdk(jelenlegiTaxon))==false
        jelenlegiTaxon = szuloIdk(jelenlegiTaxon);
        osok(end+1) = jelenlegiTaxon;
    end
    
    for j = 2:size(kivalasztottTaxonok,2)
        jelenlegiTaxon = kivalasztottTaxonok(j);
        taxonOsok = jelenlegiTaxon;
        while isnan(szuloIdk(jelenlegiTaxon))==false
            jelenlegiTaxon = szuloIdk(jelenlegiTaxon);
            taxonOsok(end+1) = jelenlegiTaxon;
        end
        osok = intersect(osok, taxonOsok, 'stable');
    end
    
    os=osok(1);
end