function [ujPointerek, ujGyoker] = TBRPointerCsere(pointers, szuloIdk, vagasTaxon, VisszaIllesztesTaxon, UjraGyokerezesTaxon, levelekDb)
    
    taxonokDb = 2 * levelekDb - 1;
    
    gyerekIdk = zeros(taxonokDb, 2);
    gyerekIdk((levelekDb+1):taxonokDb, :) = pointers; 

    %részfa levágás
    vagasTaxonSzulo = szuloIdk(vagasTaxon);
    if gyerekIdk(vagasTaxonSzulo, 1) == vagasTaxon
        vagasTaxonTestver = gyerekIdk(vagasTaxonSzulo, 2);
    else
        vagasTaxonTestver = gyerekIdk(vagasTaxonSzulo, 1);
    end
    NagySzulo = szuloIdk(vagasTaxonSzulo);
    
    if NagySzulo ~= 0
        if gyerekIdk(NagySzulo, 1) == vagasTaxonSzulo
            gyerekIdk(NagySzulo, 1) = vagasTaxonTestver;
        else
            gyerekIdk(NagySzulo, 2) = vagasTaxonTestver;
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
        
        if gyerekIdk(vagasTaxon, 1) == gyerekUton
            masikGyerek = gyerekIdk(vagasTaxon, 2);
        else
            masikGyerek = gyerekIdk(vagasTaxon, 1);
        end
        
        elozoGyerek = UjraGyokerezesTaxon;
        for i = 1:length(ut)-1
            jelenlegiTaxon = ut(i);
            szuloTaxon = ut(i+1);
            
            uresHely = 1;
            if gyerekIdk(jelenlegiTaxon, 1) == elozoGyerek
                uresHely = 2;
            end
            
            if szuloTaxon == vagasTaxon
                gyerekIdk(jelenlegiTaxon, uresHely) = masikGyerek;
                szuloIdk(masikGyerek) = jelenlegiTaxon;
            else
                gyerekIdk(jelenlegiTaxon, uresHely) = szuloTaxon;
                szuloIdk(szuloTaxon) = jelenlegiTaxon;
            end
            elozoGyerek = jelenlegiTaxon;
        end
        
        ujGyoker = vagasTaxon; 
        if length(ut) == 1
            gyerekIdk(ujGyoker, 1) = UjraGyokerezesTaxon;
            gyerekIdk(ujGyoker, 2) = masikGyerek;
            szuloIdk(masikGyerek) = ujGyoker;
        else
            gyerekIdk(ujGyoker, 1) = UjraGyokerezesTaxon;
            gyerekIdk(ujGyoker, 2) = ut(1);
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
        if gyerekIdk(visszaCsatlakozasSzulo, 1) == VisszaIllesztesTaxon
            gyerekIdk(visszaCsatlakozasSzulo, 1) = vagasTaxonSzulo;
        else
            gyerekIdk(visszaCsatlakozasSzulo, 2) = vagasTaxonSzulo;
        end
        szuloIdk(vagasTaxonSzulo) = visszaCsatlakozasSzulo;
    else
        szuloIdk(vagasTaxonSzulo) = 0;
    end
    
    gyerekIdk(vagasTaxonSzulo, 1) = VisszaIllesztesTaxon;
    gyerekIdk(vagasTaxonSzulo, 2) = tenylegesAlfaGyoker;
    szuloIdk(VisszaIllesztesTaxon) = vagasTaxonSzulo;
    szuloIdk(tenylegesAlfaGyoker) = vagasTaxonSzulo;
    
    ujPointerek = gyerekIdk((levelekDb+1):end, :);
    
    ujGyoker = find(szuloIdk == 0); 
end