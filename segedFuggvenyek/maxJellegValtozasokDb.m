% Kiszámolja a maximum lehetséges jellegváltozásokat egy fán (Gyakorlati/operatív értelmezés szerint)
function maxJellegValtozasokDb = maxJellegValtozasokDb(tablazat, levelekDb)
    jellegekDb = size(tablazat, 2);
    maxJellegValtozasokDb = 0;
    
    for i = 1:jellegekDb
        aktualisJelleg = tablazat(1:levelekDb, i);
        
        [~, ~, idx] = unique(aktualisJelleg);
        gyakorisagok = accumarray(idx, 1);
        
        maxJellegValtozasokJellegre = levelekDb - max(gyakorisagok);
        
        maxJellegValtozasokDb = maxJellegValtozasokDb + maxJellegValtozasokJellegre;
    end
end