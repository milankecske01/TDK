function szuloIdk = szulok(tree)

levelekDb = get(tree, "NumLeaves");
pointerek = get(tree, "Pointers");
belsotaxononDb = size(pointerek, 1);

gyokerId = levelekDb + belsotaxononDb;
szuloIdk = NaN(gyokerId, 1);% a gyökér az NaN

    for i = 1:belsotaxononDb
        jelenlegiTaxonId = levelekDb + i;     
        gyerekek = pointerek(i, :);
        szuloIdk(gyerekek) = jelenlegiTaxonId;
    end
end