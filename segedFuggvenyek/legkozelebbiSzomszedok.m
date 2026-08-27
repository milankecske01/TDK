% Visszaadja az 1 távolságra lévő szomszédjait egy adott fának
% Szomszéd definíció NNI szerint

function szomszedok = legkozelebbiSzomszedok(fa)

levelekDb = get(fa, 'NumLeaves');
pointerek = get(fa, 'Pointers');
levelNevek = get(fa, 'LeafNames');
belsoTaxonokDb = size(pointerek, 1);
taxonokDb=levelekDb+belsoTaxonokDb;
szomszedok = {};

gyokerId=levelekDb+belsoTaxonokDb;

szuloIdk=szulok(fa);
disp("mindegyik taxon szülőjének id-je növekvő sorrend")
disp(szuloIdk)

for i = levelekDb+1:taxonokDb
    if i == gyokerId
        continue;
    end
end