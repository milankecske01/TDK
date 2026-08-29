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
% négy új topológiát ad
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
            A=pointerek(gyerekek(1)-levelekDb,1);
            B=pointerek(gyerekek(1)-levelekDb,2);
            C=gyerekek(2);

            szomszedok{end+1}=phytree(alfaCsere(fa,A,C),levelNevek);
            szomszedok{end+1}=phytree(alfaCsere(fa,B,C),levelNevek);
            continue;
    end
    if  gyerekek(1)<=levelekDb&&gyerekek(2)>levelekDb % első levél, második belső
        A=pointerek(gyerekek(2)-levelekDb,1);
        B=pointerek(gyerekek(2)-levelekDb,2);
        C=gyerekek(1);

        szomszedok{end+1}=phytree(alfaCsere(fa,A,C),levelNevek);
        szomszedok{end+1}=phytree(alfaCsere(fa,B,C),levelNevek);
        continue;
    end
    if  gyerekek(1)>levelekDb&&gyerekek(2)>levelekDb % mindkettő belső
        A=pointerek(gyerekek(1)-levelekDb,1);
        B=pointerek(gyerekek(1)-levelekDb,2);
        C=pointerek(gyerekek(2)-levelekDb,1);
        D=pointerek(gyerekek(2)-levelekDb,2);
        X=gyerekek(1);
        Y=gyerekek(2);

        szomszedok{end+1}=phytree(alfaCsere(fa,A,Y),levelNevek);
        szomszedok{end+1}=phytree(alfaCsere(fa,B,Y),levelNevek);
        szomszedok{end+1}=phytree(alfaCsere(fa,C,X),levelNevek);
        szomszedok{end+1}=phytree(alfaCsere(fa,D,X),levelNevek);
        continue;
    end
end
end
