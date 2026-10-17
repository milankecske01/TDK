% kap egy fát és visszaadja a megtartási indexét
function RI=RIEgyFara(fa)
    taxonokDb=get(fa.szerkezet,"NumNodes");
    pointerek=get(fa.szerkezet,"Pointers");
    levelekDb=get(fa.szerkezet,"NumLeaves");
    tablazat=fa.tablazat;
    
    minimum = minJellegValtozasokDb(tablazat, levelekDb);
    tenyleges = tenylegesJellegValtozasokDb(tablazat, pointerek, taxonokDb);
    maximum=maxJellegValtozasokDb(tablazat,levelekDb);
    
    RI=(maximum-tenyleges)/(maximum-minimum);
end