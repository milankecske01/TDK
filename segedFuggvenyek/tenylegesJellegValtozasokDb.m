% Kiszámolja a tényleges jellegváltozások számát az adott fán (Fitch-hossz)
function db = tenylegesJellegValtozasokDb(tablazat, pointerek, taxonokDb)
jellegekDb = size(tablazat, 2);
tablazat=table2array(tablazat);
db = 0;
levelekDb=(taxonokDb+1)/2;
for i = 1:jellegekDb
    sor = [];
    sor(1) = taxonokDb;
    while ~isempty(sor)
        jelenlegiTaxonId = sor(end);
        sor(end) = [];
        gyerekek = pointerek(jelenlegiTaxonId - levelekDb, :);
        for k = 1:2
            if tablazat(jelenlegiTaxonId, i) ~= tablazat(gyerekek(k), i)
                db = db + 1;
            end
            if gyerekek(k) > levelekDb
                sor(end+1) = gyerekek(k);
            end
        end
    end
end
end