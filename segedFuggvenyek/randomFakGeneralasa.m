
% kap egy fak tömböt, és generál bele random fákat
% tudja a fő függvényben meghatározott waitbar-t is kezelni
function fak = randomFakGeneralasa(fak, randomFakDb, tablazat, beszedes, waitBarHandle)
if beszedes
    clear waitBarUpdate;
    waitbar(0, waitBarHandle, 'Fák generálása folyamatban...');
    set(waitBarHandle, 'Name', "Fák generálása");
    drawnow;

    D = parallel.pool.DataQueue;
    afterEach(D, @(~) waitBarUpdate(waitBarHandle, randomFakDb));
end

parfor i = 1:randomFakDb
    obj = fa();

    generaltFa = randomFa(tablazat);

    obj.szerkezet = generaltFa;
    obj.fitchHossz = Fitch(get(generaltFa, "Pointers"), tablazat);
    obj.tablazat = tablazat;

    fak(i) = obj;

    if beszedes
        send(D, 1); 
    end
end

if beszedes
    clear waitBarUpdate;
end
end