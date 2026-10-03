
if ~matlab.addons.isAddonEnabled("Bioinformatics Toolbox")
    error('Nincs letöltve a Bioinformatics Toolbox addon');
end
[fajl, eleresiut] = uigetfile('*.mat', 'Válaszd ki a táblázatot tartalmazó .mat fájlt!');
if fajl == 0
    error('Nem választottál ki fájlt.');
end
betoltes = load(fullfile(eleresiut, fajl));
valtozok = fieldnames(betoltes);
[idx, ok] = listdlg('ListString', valtozok, 'Name', 'Melyik változó a táblázat?');
if ok
    tablazat = betoltes.(valtozok{idx});
else
    error('Nem választottál változót.');
end
B=get(faClass.szerkezet,'Pointers');
eredmeny=Fitch(B,tablazat);