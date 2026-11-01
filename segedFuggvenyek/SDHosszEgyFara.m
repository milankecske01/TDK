

%Megmondja egy fának az SD hosszát, az SD hossz azt jelenti, hogy minden él
%távolságának az összegét összeadjuk, ha egy él távolságát a két végén lévő
% taxon Sorensen-Dice távolsága alapján mondjuk meg
function hossz = SDHosszEgyFara(fa)
pointerek = get(fa.szerkezet, 'Pointers');
levelekDb = get(fa.szerkezet, 'NumLeaves');
belsoTaxonokDb = size(pointerek, 1);

jellegek = fa.tablazat{:, :}; 

hossz = 0;

for i = 1:belsoTaxonokDb
    szuloId = levelekDb + i; 

    szuloJellegek = jellegek(szuloId, :);

    gyerek1Id = pointerek(i, 1);
    gyerek1Jellegek = jellegek(gyerek1Id, :);
    hossz1 = sorensenDice(szuloJellegek, gyerek1Jellegek);

    gyerek2Id = pointerek(i, 2);
    gyerek2Jellegek = jellegek(gyerek2Id, :);
    hossz2 = sorensenDice(szuloJellegek, gyerek2Jellegek);

    hossz = hossz + hossz1 + hossz2;
end
end