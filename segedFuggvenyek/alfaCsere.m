
% Kap egy fát (phytree objektum) és két indexet.
% Majd visszaad egy új mátrixot "pointers", ahol a két megadott index meg van cserélve.
% Csak olyan fákra működik, ahol nincsenek megadva távolságok
function ujPointerek = alfaCsere(fa, elsoId, masodikId)

P=get(fa,"Pointers");
levelekDb = get(fa,"NumLeaves");
belsoTaxonokDb=levelekDb-1;
taxonokDb = size(P,1) + levelekDb;

[sorElsoSzulo, oszlopElsoSzulo] = find(P == elsoId);
[sorMasodikSzulo, oszlopMasodikSzulo] = find(P == masodikId);

if isempty(sorElsoSzulo) || isempty(sorMasodikSzulo)
    error('Legalább az egyik megadott taxon az gyökér vagy nem létezik.');
end
if sorElsoSzulo == sorMasodikSzulo
    error('Nincs értelme megcserélni testvér taxonokat.');
end

if elsoId<=levelekDb||masodikId<=levelekDb
    error('Leveleket nem lehet cserélni.');
end 


P(sorElsoSzulo, oszlopElsoSzulo) = masodikId;
P(sorMasodikSzulo, oszlopMasodikSzulo) = elsoId;


% Ez azért kell, mert nem lehet feltételezni, hogy a legnagyobb id-jú taxon
% lesz a gyökér egy csere után.
osszesNode = 1:taxonokDb;
gyerekLista = P(:)';
gyokerLista = setdiff(osszesNode, gyerekLista);
if length(gyokerLista) ~= 1
    error('A fa struktúra érvénytelen, több gyökér van vagy szétesett.');
end
gyokerId = gyokerLista(1);

    ujIdk = 1:taxonokDb; 
    belsoTaxonId = levelekDb + 1;

    stack = {gyokerId, false};
    while ~isempty(stack)
        taxon = stack{end, 1};
        feldolgozva = stack{end, 2};
        stack(end, :) = [];

        if taxon <= levelekDb
            continue;
        else
            if feldolgozva
                ujIdk(taxon) = belsoTaxonId;
                belsoTaxonId = belsoTaxonId + 1;
            else
                stack(end+1, :) = {taxon, true};
                idx = taxon - levelekDb;
                gyerek1 = P(idx, 1);
                gyerek2 = P(idx, 2);
                stack(end+1, :) = {gyerek1, false};
                stack(end+1, :) = {gyerek2, false};
            end
        end
    end

    forditottMap = zeros(1, taxonokDb);
    for eredeti = levelekDb+1 : taxonokDb
        forditottMap(ujIdk(eredeti)) = eredeti;
    end

    ujPointerek = zeros(belsoTaxonokDb, 2);
    for ujId = levelekDb+1 : taxonokDb
        eredeti = forditottMap(ujId);
        idx = eredeti - levelekDb;
        gyerek1 = P(idx, 1);
        gyerek2 = P(idx, 2);
        ujPointerek(ujId - levelekDb, 1) = ujIdk(gyerek1);
        ujPointerek(ujId - levelekDb, 2) = ujIdk(gyerek2);
    end
end