% Egy fára kiszámolja az AQ pontszámot
% Ha nem jelenik meg semelyik jelleg a fán, akkor -1-et ad vissza
function pontszam=AQPontszamEgyFara(fa,jellegParok)
    jellegParokDb=size(jellegParok,1);
    pontszam=0;
    pointerek = get(fa.szerkezet,"Pointers");
    szuloIdk = szulok(fa.szerkezet);
    tablazat=table2array(fa.tablazat);
    levelekDb=get(fa.szerkezet,"NumLeaves");
    if jellegParokDb==0
        pontszam=-1;
        warning("AQ egy fára nem volt értelmezhető.")
        return;
    end
    for i=1:jellegParokDb

        kivalasztottTaxonok = find(tablazat(1:levelekDb, jellegParok(i,1)) == 1 | tablazat(1:levelekDb, jellegParok(i,2)) == 1)';
        
        if isempty(kivalasztottTaxonok)
            continue;
        end
        os=legkozelebbiKozosOs(kivalasztottTaxonok,szuloIdk);
        levelekAlfabanDb = levelekDbAlfaban(os,pointerek,levelekDb);
        pontszam = pontszam + size(kivalasztottTaxonok,2)/levelekAlfabanDb;
    end
    pontszam=pontszam/jellegParokDb;
end

