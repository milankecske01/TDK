function vonalakKirajzolasa(vonalAdatok, ablakNev, grafikonCim, xTengelyFelirat, yTengelyFelirat, jelmagyarazatElotag, yKezdet, xKezdet)
    if nargin < 8 || isempty(xKezdet)
        xKezdet = 1;
    end

    figure('Name', ablakNev);
    hold on;
    
    legNagyobbX = xKezdet - 1; 
    vonalakDb = length(vonalAdatok);
    
    for i = 1:vonalakDb
        jelenlegiVonal = vonalAdatok{i};
        if ~isempty(jelenlegiVonal)
            xErtekek = xKezdet : (xKezdet + length(jelenlegiVonal) - 1);
            
            if max(xErtekek) > legNagyobbX
                legNagyobbX = max(xErtekek);
            end
            
            plot(xErtekek, jelenlegiVonal, '-o', 'LineWidth', 1.5, 'MarkerSize', 5, ...
                'DisplayName', sprintf('%s %d', jelmagyarazatElotag, i)); 
        end
    end
    
    title(grafikonCim);
    xlabel(xTengelyFelirat);
    ylabel(yTengelyFelirat);
    grid on;
    
    if legNagyobbX >= xKezdet
        xticks(xKezdet:legNagyobbX); 
    end
    
    if nargin >= 7 && ~isempty(yKezdet)
        ylim([yKezdet, inf]); 
    end

    yErtekek = yticks;
    yticks(yErtekek(yErtekek == round(yErtekek)));
    
    legend('show', 'Location', 'northeast'); 
    hold off;
end