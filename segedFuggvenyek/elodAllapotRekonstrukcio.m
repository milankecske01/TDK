%gyakorlatilag az
%"ANN5_pelda_elodallapotok.m" olyan változata, ami kompatibilis az én kódom
%mal (phytree objektum, más beolvasás, stb...)
% kap egy táblázatot, és egy phytree-t, és a táblázathoz hozzáad egy sort,
% minden belső taxonra, és ezekbe a sorokba belerakja a becsült elődállapot
% okat.
%egyelőre autoencoder nélkül, de majd azt is belerakom.
function [tablazat, fa] = elodAllapotRekonstrukcio(tablazat, fa)
    levelekDb = get(fa, 'NumLeaves');
    pointerek = get(fa, 'Pointers');
    nevek=get(fa,"NodeNames");
    belsoTaxonokDb = size(pointerek, 1);
    taxonokDb=levelekDb+belsoTaxonokDb;
    
    % bővítjük a táblázatot
    tablazat = resize(tablazat,height(tablazat)+belsoTaxonokDb);
    tablazat.Properties.RowNames=nevek;
    for i = levelekDb+1:taxonokDb
        
    end
end