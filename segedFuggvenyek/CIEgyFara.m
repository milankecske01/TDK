% kap egy fát és visszaadja a konzisztencia indexét (CI)
function CI=CIEgyFara(fa)
    taxonokDb=get(fa.szerkezet,"NumNodes");
    pointerek=get(fa.szerkezet,"Pointers");
    levelekDb=get(fa.szerkezet,"NumLeaves");
    tablazat=fa.tablazat;
    jellegekDb=size(tablazat,2);
    minjellegValtozasokDb=0;
    for i = 1:jellegekDb
        minjellegValtozasokDb=minjellegValtozasokDb+numunique(tablazat(1:levelekDb,i))-1;
    end

    tenylegesJellegValtozasokDb=0;
    for i = 1:jellegekDb
        sor=[];
        sor(1)=taxonokDb;
        while ~isempty(sor)
            jelenlegiTaxonId=sor(end);
            sor(end)=[];
            gyerekek=pointerek(jelenlegiTaxonId-levelekDb,:);
            for k = 1:2
                if tablazat(jelenlegiTaxonId,i) ~= tablazat(gyerekek(k),i)
                    tenylegesJellegValtozasokDb=tenylegesJellegValtozasokDb+1;
                end
                if gyerekek(k)>levelekDb
                    sor(end+1)=gyerekek(k);
                end
            end
        end
    end
    CI=minjellegValtozasokDb/tenylegesJellegValtozasokDb;
end