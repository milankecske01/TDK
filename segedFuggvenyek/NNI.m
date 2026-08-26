% Nearest neighbour interchange algoritmus implementációja
% bemenetek: fa=phylotree objektum
% tablazat= a fa taxonjainat jellegállapotai táblázatban
% Működés:
% Mindig nyílvántartunk egy legjobb fát
% végigmegyünk a fán, a gyökértől a levelek felé indulva, és minden belső
% taxonnál, aminek, a gyerekeinek is van két gyereke, a következőt
% csináljuk:
% legyen a jelenleg nézett taxon E, az ebből kijövő fa ((A,B),(C,D))
% Ezt háromféleképpen lehet rendezni:
% ((A,C),(B,D)) és ((A,D),(C,B)) és az eredeti ((A,B),(C,D))
% a három lehetőség közül kiválasztjuk a legparszimonikusabbat, és az lesz
% az új legjobbb fa. Majd elkezdjük a gyökérből nézni megint.
% addig megyünk, amíg végig nem megyünk egyszer a fán úgy, hogy nem találunk
% jobb fát.
function eredmeny = NNI(fa,tablazat)
end


%legenerálja az összes szomszédot
function szomszedok = NNIOsszesSzomszed(fa,tablazat)

belsoPontokDb = get(fa,"NumBranches");
levelekDb = get(fa,"NumLeaves");

end
function id=getGyerekId(faPointerek,szuloId)
    id=faPointerek(szuloId)
end