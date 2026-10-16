% Fitch algoritmus rendezetlen P mátrixra (rekurzív poszt-order bejárással).
% P: A (rendezetlen) mutató mátrix
% tablazat: A levelek jellegeit tartalmazó table objektum
% gyokerId: A fa (aktuális) gyökerének azonosítója
function hosszusag = fitchRendezetlenMatrixxal(P, tablazat, gyokerId)

matrix = table2array(tablazat);
levelekDb = size(matrix, 1);
jellegekDb = size(matrix, 2);

[hosszusag, ~] = fitchRekurzio(gyokerId);

    function [pont, jellegHalmaz] = fitchRekurzio(taxonId)

        jellegHalmaz = cell(1, jellegekDb);

        if taxonId <= levelekDb
            pont = 0;
            for ch = 1:jellegekDb
                jellegHalmaz{ch} = matrix(taxonId, ch);
            end
            return;
        end

        idx = taxonId - levelekDb;
        gyerek1 = P(idx, 1);
        gyerek2 = P(idx, 2);

        [pont1, halmaz1] = fitchRekurzio(gyerek1);
        [pont2, halmaz2] = fitchRekurzio(gyerek2);

        pont = pont1 + pont2;
        for ch = 1:jellegekDb
            metszet = intersect(halmaz1{ch}, halmaz2{ch});

            if ~isempty(metszet)
                jellegHalmaz{ch} = metszet;
            else
                jellegHalmaz{ch} = union(halmaz1{ch}, halmaz2{ch});
                pont = pont + 1;
            end
        end
    end
end