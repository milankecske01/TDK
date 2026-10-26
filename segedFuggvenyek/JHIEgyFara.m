% kap egy fát és visszaadja a súlyozott holofiletikus indexét (JHI)
% egy HI kiszámításához (egy osztályhoz) a következő az algoritmus:
% keressünk olyan diszjunkt holofiletikus csoportokat, ahol az összes levél
% taxon, tagja az adott osztálynak, és mindegyik levél taxon a csoportban,
% majd nézzük, meg hogy
% csoportonként,mekkora részét tudjuk lefedni a csoportnak,
% ilyen holofiletikus csoportokkal, majd adjuk ezeket a pontokat össze
% súlyozva
function JHI=JHIEgyFara(fa,osztalyok)
    osztalyokDb=length(osztalyok);
    if osztalyokDb==0 || sum(cellfun(@numel, osztalyok)) == 0
        JHI=-1;
        warning("JHI egy fára nem volt értelmezhető.")
        return;
    end
    JHI=0;
    for i = 1:osztalyokDb
        HI=HIEgyCsoportra(fa,osztalyok{i});
        JHI=JHI+HI*numel(osztalyok{i});
    end
    JHI=JHI/sum(cellfun(@numel, osztalyok));
end