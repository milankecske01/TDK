function pontszam=AQPontszamEgyFara(fa,jellegParok)
    jellegParokDb=size(jellegParok,1);
    pontszam=0;
    pointerek = get(fa.szerkezet,"Pointers");
    szuloIdk = szulok(fa.szerkezet);
    taxonokDb = get(fa.szerkezet,"NumNodes");
    tablazat=table2array(fa.tablazat);
    levelekDb=get(fa.szerkezet,"NumLeaves");
    for i=1:jellegParokDb
        kivalasztottTaxonok=[];

        for j = 1:taxonokDb
            if tablazat(j,jellegParok(i,1))==1||tablazat(j,jellegParok(i,2))==1
                kivalasztottTaxonok(end+1)=j;
            end
        end
        os=legkozelebbiKozosOs(kivalasztottTaxonok,szuloIdk);

        if isempty(os)
            continue;
        end
        taxonokAlfabanDb = taxonokDbAlfaban(os,pointerek,levelekDb);
        if taxonokAlfabanDb==0 % ha nincs ilyen elem, akkor kihagyjuk a jellegpárt
            continue;
        end
        pontszam = pontszam + size(kivalasztottTaxonok,2)/taxonokAlfabanDb;
    end
    pontszam=pontszam/jellegParokDb; % ha valamelyik jellegpár 0 megfelelő taxont talál, akkor a "jellegParokDb"-ből levonjak 1-et?
end

