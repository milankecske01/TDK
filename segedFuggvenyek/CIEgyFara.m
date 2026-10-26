% Kap egy fát, és visszaadja a konzisztenciaindexét (CI)
function CI = CIEgyFara(fa)

    levelekDb = get(fa.szerkezet, "NumLeaves");
    tablazat = fa.tablazat;

    minimum = minJellegValtozasokDb(tablazat, levelekDb);
    tenyleges = fa.fitchHossz;

    if tenyleges == 0
        CI = -1;
        warning("CI egy fára nem volt értelmezhető.")
        return;
    end

    CI = minimum / tenyleges;
end