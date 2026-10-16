% Kap egy P pointer mátrixot, és egy N x 2-es "csereParok" mátrixot.
% Minden sora a csereParok-nak [elsoId, masodikId] formátumú.
function P = pointerCserek(P, csereParok)
for i = 1:size(csereParok, 1)
    elsoId = csereParok(i, 1);
    masodikId = csereParok(i, 2);

    [sorElso, oszlopElso] = find(P == elsoId);
    [sorMasodik, oszlopMasodik] = find(P == masodikId);

    if isempty(sorElso) || isempty(sorMasodik)
        error('Hiba a %d. cserénél: Legalább az egyik taxon gyökér vagy nem létezik.', i);
    end
    if sorElso == sorMasodik
        warning('A %d. cserénél testvéreket próbálsz cserélni, ezt a cserét kihagytam.', i);
        continue;
    end

    % Csere végrehajtása
    P(sorElso, oszlopElso) = masodikId;
    P(sorMasodik, oszlopMasodik) = elsoId;
end
end