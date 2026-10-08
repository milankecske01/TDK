
% Több fára kiszámolja az AQ pontszámot, és egy waitBar-t is updatel közben
% Ha nem jelenik meg semelyik jelleg a fán, akkor -1-et ad vissza
function fak= AQPontszamokTobbFara(fak,jellegParok,waitTimerHandle,beszedes)
    fakDb=size(fak,2);
    if beszedes
        set(waitTimerHandle, 'Name', "AQ értékek keresése");
        waitbar(0, waitTimerHandle, sprintf("0/%d", fakDb));
        drawnow;
        D = parallel.pool.DataQueue;
        afterEach(D, @(~) waitBarUpdate(waitTimerHandle, fakDb));
    end
    parfor i = 1:fakDb
        fak(i).AQPontszam=AQPontszamEgyFara(fak(i),jellegParok)
        if beszedes
            send(D, 1); 
        end
    end

    if beszedes
        clear waitBarUpdate;
    end

end

