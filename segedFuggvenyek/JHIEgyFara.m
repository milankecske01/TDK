% kap egy fát és visszaadja a súlyozott holofiletikus indexét (JHI)
% egy HI kiszámításához (egy osztályhoz) a következő az algoritmus:
% keressünk olyan diszjunkt holofiletikus csoportokat, ahol az összes levél
% taxon, tagja az adott osztálynak, és mindegyik levél taxon a csoportban,
% kevésbé különbözik a csoport öszes elemének közös ősétől, mint bármely,
% taxon ami nincs benne a csoportban.
% (különbözőség, tetszőleges metrika, amit megadunk, gyakorlatban a Sørensen-dice-ot használjuk.)
function JHI=JHIEgyFara(fa,csoportok,tavolsagMertek)
    csoportokDb=size(csoportok);
    JHI=0;
    for i = 1:csoportokDb
        HI=HIEgyCsoportra(fa,csoportok(i),tavolsagMertek);
        JHI=JHI+HI;
    end
    JHI=JHI/csoportokDb;
end