% kap egy fát és visszaadja a súlyozott holofiletikus indexét (JHI)
% egy HI kiszámításához (egy osztályhoz) a következő az algoritmus:
% keressünk olyan diszjunkt holofiletikus csoportokat, ahol az összes levél
% taxon, tagja az adott osztálynak, és mindegyik levél taxon a csoportban,
% kevésbé különbözik a csoport öszes elemének közös ősétől, mint bármely,
% taxon ami nincs benne a csoportban.
% (különbözőség, tetszőleges metrika, amit megadunk, gyakorlatban a Sørensen-dice-ot használjuk.)
function JHI=JHIEgyFara(fa,osztalyok)
    csoportokDb=length(osztalyok);
    JHI=0;
    for i = 1:csoportokDb
        HI=HIEgyCsoportra(fa,osztalyok{i});
        JHI=JHI+HI*numel(osztalyok{i});
    end
    JHI=JHI/sum(cellfun(@numel, osztalyok));
end