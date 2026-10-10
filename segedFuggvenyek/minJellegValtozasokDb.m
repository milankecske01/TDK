% Kiszámolja a minimális jellegváltozások számát (elméleti minimum)
function minjellegValtozasokDb = minJellegValtozasokDb(tablazat, levelekDb)
    jellegekDb = size(tablazat, 2);
    minjellegValtozasokDb = 0;
    for i = 1:jellegekDb
        minjellegValtozasokDb = minjellegValtozasokDb + numunique(tablazat(1:levelekDb, i)) - 1;
    end
end