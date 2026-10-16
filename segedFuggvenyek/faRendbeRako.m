% Kap egy (akár rendezetlen) P pointer mátrixot és a levelek számát.
% Visszaad egy topologikusan helyes, phytree-kompatibilis pointer mátrixot.
function ujPointerek = faRendbeRako(P, levelekDb)
belsoTaxonokDb = size(P, 1);
taxonokDb = belsoTaxonokDb + levelekDb;

% Gyökér megkeresése
osszesNode = 1:taxonokDb;
gyerekLista = P(:)';
gyokerLista = setdiff(osszesNode, gyerekLista);

if length(gyokerLista) ~= 1
    error('A fa struktúra érvénytelen, több gyökér van vagy szétesett (esetleg kör keletkezett a cserék során).');
end
gyokerId = gyokerLista(1);

% Bejárás és új ID-k kiosztása
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