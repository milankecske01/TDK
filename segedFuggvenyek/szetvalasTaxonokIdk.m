% kap egy fát, egy táblázatot jellegekkel, és egy idk listát. az idk-ben
% minden sorban 2 id lesz, ez 2 jelleg id-je. a függvény visszaadja, hogy
% ez a kettő id, melyik id-jű nem levél taxonokban nem egyenlő.

function szetvalasok = szetvalasTaxonokId(fa, tablazat, idk)
levelekDb = get(fa, 'NumLeaves');
pointerek = get(fa, 'Pointers');
belsoTaxonokDb = size(pointerek, 1);
taxonokDb=levelekDb+belsoTaxonokDb;
potencialisSzetvalasokDb=size(idk,1);

szetvalasok=cell(potencialisSzetvalasokDb,1);

for i = 1:potencialisSzetvalasokDb
    for j = levelekDb+1:taxonokDb
        if (tablazat{j,idk(i,1)}==tablazat{j,idk(i,2)})
            continue;
        end
        szetvalasok{i}(end+1)=j;
    end
end