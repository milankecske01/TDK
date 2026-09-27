% Kap egy fa objektumot, és jelleg párokat.
% Megnyit egy figure-t, és rak az aljára egy menüt, ahol jellegpárokat lehet
% választani. A kiválasztott jellegeket ábrázolja a fán, minden taxonra,
% jelzi, hogy csak az első, csak a második, vagy mindkettő értéke 1-e.

function interaktivFa(fa, jellegParok)
    plot(fa.szerkezet, 'BranchLabels', true);
    set(gca, 'Color', 'w');

    
    jellegNevek = fa.tablazat.Properties.VariableNames;
    taxonNevek = fa.tablazat.Properties.RowNames;
    
    fig = gcf;
    ax = gca;
    
    ax.Position = [0.05, 0.15, 0.8, 0.8]; 
    
    dropDownLehetosegek = cell(size(jellegParok, 1) + 1, 1);
    dropDownLehetosegek{1} = "Válassz ki egy jelleg párt!";
    
    for i = 1:size(jellegParok, 1)
        id1 = jellegParok(i, 1);
        id2 = jellegParok(i, 2);
        dropDownLehetosegek{i+1} = sprintf('%s - %s', jellegNevek{id1}, jellegNevek{id2});
    end
    
    dropdown = uicontrol(fig, ...
        'Style', 'popupmenu', ...
        'String', dropDownLehetosegek, ...
        'Units', 'normalized', ...
        'Position', [0.2, 0.05, 0.6, 0.05], ... 
        'Callback', @(src, event) dropdownCallback(src));
    
    function dropdownCallback(src)
        delete(findobj(ax, 'Tag', 'CustomMarker'));
        
        if src.Value == 1
            return;
        end
        
        valasztottSor = src.Value - 1;
        id1 = jellegParok(valasztottSor, 1);
        id2 = jellegParok(valasztottSor, 2);
        
        hold(ax, 'on');
        
        for k = 1:length(taxonNevek)
            aktualisTaxon = taxonNevek{k};
            
            ertek1 = fa.tablazat{aktualisTaxon, id1};
            ertek2 = fa.tablazat{aktualisTaxon, id2};
            
            rajzolniKell = true;
            if ertek1 == 1 && ertek2 == 0
                szimbolum="o";
            elseif ertek1 == 0 && ertek2 == 1
                szimbolum="square";
            elseif ertek1 == 1 && ertek2 == 1
                szimbolum="pentagram";
            else
                rajzolniKell = false;
            end
            
            if rajzolniKell
                taxonLabel = findobj(ax, 'Type', 'text', 'String', aktualisTaxon);
                taxonLabel = taxonLabel(1);

                if ~isempty(taxonLabel)

                    pozicio = get(taxonLabel, 'Position'); 
                    x = pozicio(1);
                    y = pozicio(2);
                    
                    plot(ax, x, y, szimbolum, ...
                        'MarkerSize', 18, ...
                        'MarkerEdgeColor', 'k', ...
                        'MarkerFaceColor', 'r', ...
                        'Tag', 'CustomMarker');
                end
            end
        end
        
        hold(ax, 'off');
    end
end