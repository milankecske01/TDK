plot(fa.szerkezet);

azonosito="τ4";
AzonositoSzoveg=sprintf("Azonosito - %s",azonosito);
CimSzoveg=sprintf("%s fa szerkezete",azonosito);
CISzoveg = sprintf('CI - %.4f', fa.CI);
RISzoveg = sprintf('RI - %.4f', fa.RI);
RCSzoveg = sprintf('RC - %.4f', fa.RI*fa.CI);
AQSzoveg = sprintf('AQ - %.4f', fa.AQPontszam);
JHISzoveg = sprintf('JHI - %.4f', fa.JHI);



fig = gcf;
fig.Color = 'w';
title(CimSzoveg, 'Color', 'black');


taxonNevek = findobj(gca, 'Type', 'text');

set(taxonNevek, 'Color', 'k');

ax = gca;
ax.Color = "w";
ax.XColor = 'k';
ax.YColor = 'k';
hold on;

plot(NaN, NaN, 'Color', 'none'); 
lgd = legend(AzonositoSzoveg, CISzoveg,RISzoveg, RCSzoveg, AQSzoveg, JHISzoveg);
lgd.FontSize = 10;
lgd.TextColor = "black";
lgd.Location = 'northwest';
legend('boxoff');

clearvars -except fa