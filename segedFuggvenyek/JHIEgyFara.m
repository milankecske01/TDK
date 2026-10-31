% Kap egy fát és visszaadja a súlyozott holofiletikus indexét (JHI).
% BEMENET: Az 'osztalyok' egy cellatömb, amiben a taxonok NEVEI vannak 
function JHI = JHIEgyFara(fa, osztalyok)
    faLevelNevek = get(fa.szerkezet, 'LeafNames');
    
    osztalyokDb = length(osztalyok);
    osztalyokIndexekkel = cell(1, osztalyokDb);
    
    for i = 1:osztalyokDb
        jelenlegiOsztalyNevek = osztalyok{i};
        
        [bentVan, faIndexek] = ismember(jelenlegiOsztalyNevek, faLevelNevek);
        
        if any(~bentVan)
            warning('A(z) %d. osztályban van olyan taxon név, ami nem szerepel a fán!', i);
        end
        
        osztalyokIndexekkel{i} = faIndexek(bentVan);
    end
    
    if osztalyokDb == 0 || sum(cellfun(@numel, osztalyokIndexekkel)) == 0
        JHI = -1;
        warning("JHI egy fára nem volt értelmezhető (vagy egyetlen név sem egyezett a fával).")
        return;
    end
    
    JHI = 0;
    for i = 1:osztalyokDb
        HI = HIEgyCsoportra(fa, osztalyokIndexekkel{i});
        JHI = JHI + HI * numel(osztalyokIndexekkel{i});
    end
    JHI = JHI / sum(cellfun(@numel, osztalyokIndexekkel));
end