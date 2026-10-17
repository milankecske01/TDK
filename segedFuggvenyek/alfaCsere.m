% Kap egy fát (phytree objektum) és két indexet.
% Visszaad egy új "Pointers" mátrixot, ahol a két megadott index meg van cserélve,
% és a mátrix topologikusan helyesen újra van indexelve.
% Megjegyzés: ez a függvény, csak azért van megtartva, hogy a régi kód
% működjön, érdemesebb használni a benne lévő függvényeket
function ujPointerek = alfaCsere(fa, elsoId, masodikId)

P = get(fa, "Pointers");

csereParok = [elsoId, masodikId];

rendezetlenP = pointerCserek(P, csereParok);

ujPointerek = faRendbeRako(rendezetlenP);

end