% Visszaadja az 1 távolságra lévő szomszédjait egy adott fának
% Szomszéd definíció NNI szerint
% működés:
% menjünk végig az összes nem levél, nem gyökér belső taxonon.
% legyen a jelenlegi taxon P.
% legyenek P gyerekei X és Y.
% ha X és Y levél, nem csinálunk semmit.
% ha X és Y küzül pontosan az egyik levél (például most legyen a belső
% taxon X) akkor legyenek X gyerekei A és B. cseréljük a két szomszédot úgy
% kapjuk meg, hogy vagy A-t vagy B-t megcseréljük Y-al.
% Ha X és Y belső taxon, akkor legyenek X gyerekei A és B. Y gyerekei C és
% D. Cseréljük ki A-t Y-al vagy B-t Y-al vagy C-t X-el vagy D-t X-el. ez
% három új topológiát ad
% nekünk. Ha végigértünk az összes belső ponton akkor készen vagyunk.

function szomszedok = legkozelebbiSzomszedok(fa)

levelekDb = get(fa, 'NumLeaves');
pointerek = get(fa, 'Pointers');
levelNevek = get(fa, 'LeafNames');
belsoTaxonokDb = size(pointerek, 1);
taxonokDb=levelekDb+belsoTaxonokDb;
szomszedok = {};


%szuloIdk=szulok(fa);

for i = 1:belsoTaxonokDb-1

    gyerekek=pointerek(i,:);
    if  gyerekek(1)<=levelekDb&&gyerekek(2)<=levelekDb % mindkettő levél
        continue;
    end

    if  gyerekek(1)>levelekDb&&gyerekek(2)<=levelekDb % első belső, második levél
            A=pointerek(gyerekek(1),1);
            B=pointerek(gyerekek(1),2);
            C=gyerekek(2);
        continue;
    end
    if  gyerekek(1)<=levelekDb&&gyerekek(2)>levelekDb % első levél, második belső
        continue;
    end
    if  gyerekek(1)>levelekDb&&gyerekek(2)>levelekDb % mindkettő belső
        continue;
    end
end
end
% megcseréli egy fának a
% pointers tömbjében a két megadott id-t és visszaadja egy új tömbben
function ujPointerek = alfaCsere(pointerek, elsoTaxonId, masodikTaxonId)

[rowA, colA] = find(pointers == nodeA);
[rowB, colB] = find(pointers == nodeB);

ujPointerek(rowA, colA) = nodeB;
ujPointerek(rowB, colB) = nodeA;

newTree = phytree(newPointers, levelNevek);
end

