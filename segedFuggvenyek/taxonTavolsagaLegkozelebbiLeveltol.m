% megmondja, egy taxon távolságát a legközelebbi levéltől
function tavolsag = taxonTavolsagaLegkozelebbiLeveltol(fa,taxonId)
    levelekDb = get(fa, 'NumLeaves');
    pointerek = get(fa, 'Pointers');
    tavolsagok = get(fa,'Distances');
    tavolsag=NaN;


    utFolytatas(-1*tavolsagok(taxonId),taxonId);



    function [id,hossz] = utFolytatas(hossz, jelenlegiTaxonId)
        hossz=hossz+tavolsagok(jelenlegiTaxonId);

        if jelenlegiTaxonId<=levelekDb %levél
            if isnan(tavolsag)||hossz<tavolsag
                tavolsag=hossz;
            end
            return;
        end   
        utFolytatas(hossz,pointerek(jelenlegiTaxonId-levelekDb,1)); %bal gyerek
        utFolytatas(hossz,pointerek(jelenlegiTaxonId-levelekDb,2)); %jobb gyerek
    end
end