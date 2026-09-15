% kap egy 2D mátrixot, és visszaadja az összes id-párt, ahol az érték 1
function parok= idParokKinyereseMatrixbol(matrix)
    parok=[];
    magassag=size(matrix,1);
    szelesseg=size(matrix,2);
    for i = 1:magassag
        for j = 1:szelesseg
            if matrix(i,j)==1
                parok=[parok;i j];
            end
        end
    end
end