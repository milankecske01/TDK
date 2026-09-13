%gyakorlatilag az
%"ANN5_pelda_elodallapotok.m" olyan változata, ami kompatibilis az én kódom
%mal (phytree objektum, más beolvasás, stb...)
% kap egy táblázatot, és egy phytree-t, és a táblázathoz hozzáad egy sort,
% minden belső taxonra, és ezekbe a sorokba belerakja a becsült elődállapot
% okat.
%egyelőre autoencoder nélkül, de majd azt is belerakom.
% minimumValoszinusegJelleghez: a minimum esély, hogy egy jelleg értéke 1
% legyen
function [tablazat, fa] = elodAllapotRekonstrukcio(tablazat, fa, minimumValoszinusegJelleghez)
    levelekDb = get(fa, 'NumLeaves');
    pointerek = get(fa, 'Pointers');
    nevek=get(fa,"NodeNames");
    belsoTaxonokDb = size(pointerek, 1);
    taxonokDb=levelekDb+belsoTaxonokDb;
    jellegekDb=size(tablazat,2);
    
    % bővítjük a táblázatot
    tablazat = resize(tablazat,height(tablazat)+belsoTaxonokDb);
    tablazat.Properties.RowNames=nevek;

    %beleírjuk a valószínűségeket a táblázatba
    for i = 1:jellegekDb
        for j = 1:belsoTaxonokDb
           gyerekekAtlagValoszinuseg = mean(tablazat{pointerek(j, :), i});
           tablazat{j+levelekDb,i}=gyerekekAtlagValoszinuseg;
        end
    end

    %a valószínűségeket lecseréljük a tényleges értékekre
    for i = levelekDb+1:taxonokDb
        for j = 1:jellegekDb
            if tablazat{i,j}>=minimumValoszinusegJelleghez
                tablazat{i,j}=1;
                continue;
            end
            tablazat{i,j}=0;
        end
    end
end