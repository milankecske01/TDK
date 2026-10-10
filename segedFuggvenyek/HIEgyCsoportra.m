% Megmondja egy fában a HI értéket egy csoportra.
function HI=HIEgyCsoportra(fa,osztaly,tavolsagMertek)
    foglaltLevelek=[];
    taxonokDb=get(fa.szerkezet,"NumNodes");
    pointerek=get(fa.szerkezet,"Pointers");
    levelekDb=get(fa.szerkezet,"NumLeaves");
    tablazat=fa.tablazat;
    for i = taxonokDb:-1:(levelekDb + 1)
        levelGyerekek=levelekAlfaban(pointerek,i);
        if numel(intersect(osztaly,levelGyerekek))~=numel(levelGyerekek) %nem csoportba tartozó levél van a csoportban
            continue;
        end
        if numel(intersect(foglaltLevelek,levelGyerekek))>0 %már le van foglalva, legalább 1 levél, egy másik csoport által
            continue;
        end

        legnagyobbTavolsag=-1;
        for j = 1:numel(levelGyerekek)
            tavolsag=pdist2(tablazat(i,:),tablazat(levelGyerekek(j),:),@tavolsagMertek);
            if tavolsag>legnagyobbTavolsag
                legnagyobbTavolsag=tavolsag;
            end
        end

        tavolsagMegfelel=true;
        for j = 1:levelekDb
            if ismember(j, levelGyerekek)
                continue;
            end
            tavolsag=pdist2(tablazat(i,:),tablazat(j,:),@tavolsagMertek);
            if tavolsag<=legnagyobbTavolsag
                tavolsagMegfelel=false;
                break;
            end
        end

        if ~tavolsagMegfelel
            continue;
        end

        foglaltLevelek=union(foglaltLevelek,levelGyerekek);
    end
    HI=numel(foglaltLevelek)/numel(osztaly);
end