% Megmondja egy fában a HI értéket egy csoportra.
function HI=HIEgyCsoportra(fa,osztaly)
    foglaltLevelek=[];
    taxonokDb=get(fa.szerkezet,"NumNodes");
    pointerek=get(fa.szerkezet,"Pointers");
    levelekDb=get(fa.szerkezet,"NumLeaves");
    if numel(osztaly)==0
        HI=0;
        return;
    else
        
    end
    for i = taxonokDb:-1:(levelekDb + 1)
        levelGyerekek=levelekAlfaban(pointerek,i);
        if numel(intersect(osztaly,levelGyerekek))~=numel(levelGyerekek) %nem csoportba tartozó levél van a csoportban
            continue;
        end
        if numel(intersect(foglaltLevelek,levelGyerekek))>0 %már le van foglalva, legalább 1 levél, egy másik csoport által
            continue;
        end

        foglaltLevelek=union(foglaltLevelek,levelGyerekek);
    end
    HI=numel(foglaltLevelek)/numel(osztaly);
end