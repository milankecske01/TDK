% Kap egy fát, és visszaadja a megtartási indexét (RI)
function RI = RIEgyFara(fa)

    levelekDb = get(fa.szerkezet, "NumLeaves");
    tablazat = fa.tablazat;

    minimum = minJellegValtozasokDb(tablazat, levelekDb);
    tenyleges = fa.fitchHossz;
    maximum = maxJellegValtozasokDb(tablazat, levelekDb);

    if maximum - minimum == 0
        RI = -1;
        return;
    end

    RI = (maximum - tenyleges) / (maximum - minimum);
end