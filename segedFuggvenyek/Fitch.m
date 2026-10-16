% Fitch algoritmus, ami meg tudna adni egy fának a hosszát (hány db változás történt)
% B= a fa szerkezete (get(fa,"Pointers"))
% tablazat= a táblázat, amiben a jellegek vannak
% Ez csak olyan B
% mátrixokon működik, amelyek megfelelnek a phytree objektum elvásárainak 
% (taxon id mindeg előbb van mint a szülője.)
function hosszusag = Fitch(B,tablazat)

data = table2array(tablazat);
numLeaves = size(data, 1);
numChars = size(data, 2);
numInternal = size(B, 1);
hosszusag = 0;

    for ch=1:numChars
            sets = cell(1, numLeaves + numInternal);

            for leaf = 1:numLeaves
                sets{leaf} = data(leaf, ch);
            end

            for i = 1:numInternal
                sets{numLeaves + i} = [];
            end

            for i = 1:numInternal
                node_id = numLeaves + i;
                left_child = B(i, 1);
                right_child = B(i, 2);

                left_set = sets{left_child};
                right_set = sets{right_child};

                inter = intersect(left_set, right_set);

                if ~isempty(inter)
                    sets{node_id} = inter;
                else
                    sets{node_id} = union(left_set, right_set);
                    hosszusag = hosszusag + 1;
                end
    end

end