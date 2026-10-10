% Kiszámolja a maximum lehetséges jellegváltozásokat egy fán (Farris féle értelmezés szerint)
function maxJellegValtozasokDb = maxJellegValtozasokDb(tablazat, levelekDb)
    jellegekDb = size(tablazat, 2);
    maxJellegValtozasokDb = 0;
    
    for i = 1:jellegekDb
        egyediAllapotokDb = numunique(tablazat(1:levelekDb, i));
    
        maxJellegValtozasokJellegre = levelekDb - egyediAllapotokDb;
    
        maxJellegValtozasokDb = maxJellegValtozasokDb + maxJellegValtozasokJellegre;
    end
end