% kap egy fát és visszaadja a konzisztencia indexét (CI)
function CI=CIEgyFara(fa)
    taxonokDb=get(fa.szerkezet,"NumNodes");
    pointerek=get(fa.szerkezet,"Pointers");
    levelekDb=get(fa.szerkezet,"NumLeaves");
    tablazat=fa.tablazat;

    minimum = minJellegValtozasokDb(tablazat, levelekDb);
    tenyleges = TenylegesJellegValtozasokSzama(tablazat, pointerek, taxonokDb, levelekDb);

    CI=minimum/tenyleges;
end