% visszaadja egy fa távolságait
% bemenetnek egy fát és egy táblázatot kér, amiből kinézheti a
% jellegeket a tavolsagMetrika lehet string, vagy egy függvény

function tavolsagok = tavolsagok(fa,tablazat,tavolsagMetrika)
    if ~(isa(tavolsagMetrika, 'function_handle')  || isstring(tavolsagMetrika))
        error('Távolság metrika az legyen string vagy function handle.');
    end


    levelekDb = get(fa, 'NumLeaves');
    pointerek = get(fa, 'Pointers');
    nevek=get(fa,"NodeNames");
    belsoTaxonokDb = size(pointerek, 1);
    taxonokDb=levelekDb+belsoTaxonokDb;
    jellegekDb=size(tablazat,2);
    tavolsagok=zeros(taxonokDb,1);

    szuloIdk= szulok(fa);
    for i = 1:taxonokDb-1
        tavolsagok(i)=pdist2(table2array(tablazat(i,:)),table2array(tablazat(szuloIdk(i),:)),tavolsagMetrika)
    end
end