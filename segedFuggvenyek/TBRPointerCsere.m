function [ujPointerek, ujGyoker] = TBRPointerCsere(pointers, szuloIdk, vagasTaxon, VisszaIllesztesTaxon, UjraGyokerezesTaxon, levelekDb)
    
    taxonokDb = 2 * levelekDb - 1;
    
    gyerek = zeros(taxonokDb, 2);
    gyerek((levelekDb+1):taxonokDb, :) = pointers; 

    %részfa levágás
    vagasTaxonSzulo = szuloIdk(vagasTaxon);
    if gyerek(vagasTaxonSzulo, 1) == vagasTaxon
        vagasTaxonTestver = gyerek(vagasTaxonSzulo, 2);
    else
        vagasTaxonTestver = gyerek(vagasTaxonSzulo, 1);
    end
    NagySzulo = szuloIdk(vagasTaxonSzulo);
    
    if NagySzulo ~= 0
        if gyerek(NagySzulo, 1) == vagasTaxonSzulo
            gyerek(NagySzulo, 1) = vagasTaxonTestver;
        else
            gyerek(NagySzulo, 2) = vagasTaxonTestver;
        end
        szuloIdk(vagasTaxonTestver) = NagySzulo;
    else
        szuloIdk(vagasTaxonTestver) = 0;
    end
    
    %újragyökereztetés
    if UjraGyokerezesTaxon ~= vagasTaxon
        ut = [];
        jelenlegiTaxon = UjraGyokerezesTaxon;
        while jelenlegiTaxon ~= vagasTaxon
            jelenlegiTaxon = szuloIdk(jelenlegiTaxon);
            ut = [ut, jelenlegiTaxon];
        end
        
        if length(ut) == 1
            gyerekUton = UjraGyokerezesTaxon;
        else
            gyerekUton = ut(end-1);
        end
        
        if gyerek(vagasTaxon, 1) == gyerekUton
            masikGyerek = gyerek(vagasTaxon, 2);
        else
            masikGyerek = gyerek(vagasTaxon, 1);
        end
        
        elozoGyerek = UjraGyokerezesTaxon;
        for i = 1:length(ut)-1
            jelenlegiTaxon = ut(i);
            szuloTaxon = ut(i+1);
            
        if gyerek(jelenlegiTaxon, 1) == elozoGyerek
            uresHely = 1;
        else
            uresHely = 2;
        end
            
            if szuloTaxon == vagasTaxon
                gyerek(jelenlegiTaxon, uresHely) = masikGyerek;
                szuloIdk(masikGyerek) = jelenlegiTaxon;
            else
                gyerek(jelenlegiTaxon, uresHely) = szuloTaxon;
                szuloIdk(szuloTaxon) = jelenlegiTaxon;
            end
            elozoGyerek = jelenlegiTaxon;
        end
        
        ujGyoker = vagasTaxon; 
        if length(ut) == 1
            gyerek(ujGyoker, 1) = UjraGyokerezesTaxon;
            gyerek(ujGyoker, 2) = masikGyerek;
            szuloIdk(masikGyerek) = ujGyoker;
        else
            gyerek(ujGyoker, 1) = UjraGyokerezesTaxon;
            gyerek(ujGyoker, 2) = ut(1);
            szuloIdk(ut(1)) = ujGyoker;
        end
        szuloIdk(UjraGyokerezesTaxon) = ujGyoker;
        tenylegesAlfaGyoker = ujGyoker;
    else
        tenylegesAlfaGyoker = vagasTaxon;
    end
    
    % újracsatlakoztatás
    visszaCsatlakozasSzulo = szuloIdk(VisszaIllesztesTaxon);
    
    if visszaCsatlakozasSzulo ~= 0
        if gyerek(visszaCsatlakozasSzulo, 1) == VisszaIllesztesTaxon
            gyerek(visszaCsatlakozasSzulo, 1) = vagasTaxonSzulo;
        else
            gyerek(visszaCsatlakozasSzulo, 2) = vagasTaxonSzulo;
        end
        szuloIdk(vagasTaxonSzulo) = visszaCsatlakozasSzulo;
    else
        szuloIdk(vagasTaxonSzulo) = 0;
    end
    
    gyerek(vagasTaxonSzulo, 1) = VisszaIllesztesTaxon;
    gyerek(vagasTaxonSzulo, 2) = tenylegesAlfaGyoker;
    szuloIdk(VisszaIllesztesTaxon) = vagasTaxonSzulo;
    szuloIdk(tenylegesAlfaGyoker) = vagasTaxonSzulo;
    
    ujPointerek = gyerek((levelekDb+1):end, :);
    
    ujGyoker = find(szuloIdk == 0); 
end