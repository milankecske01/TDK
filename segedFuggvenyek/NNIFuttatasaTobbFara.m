function [fak, NNIPontszamok, NNIPontszamokCsokkenes] = NNIFuttatasaTobbFara(fak, tablazat, fakDb, beszedes, waitTimerHandle, NNIPontszamokMemorizalas, NNIPontszamokCsokkenesMemorizalas)

    if beszedes
        set(waitTimerHandle, 'Name', "NNI futtatása");
        waitbar(0, waitTimerHandle, sprintf("0/%d", fakDb));
        drawnow;
        D = parallel.pool.DataQueue;
        afterEach(D, @(~) waitBarUpdate(waitTimerHandle, fakDb));
    end
    
    NNIPontszamok = cell(1, fakDb);
    NNIPontszamokCsokkenes = cell(1, fakDb);
    
    parfor i = 1:fakDb
        [optimalizaltFa, helyiNNIPontszamok, helyiNNIPontszamCsokkenesek] = ...
            NNIFuttatasaEgyFara(fak(i), tablazat, NNIPontszamokMemorizalas, NNIPontszamokCsokkenesMemorizalas);
    
        fak(i) = optimalizaltFa;
    
        if NNIPontszamokMemorizalas
            NNIPontszamok{i} = helyiNNIPontszamok;
        end
        if NNIPontszamokCsokkenesMemorizalas
            NNIPontszamokCsokkenes{i} = helyiNNIPontszamCsokkenesek;
        end
    
        if beszedes
            send(D, 1); 
        end
    end
    
        if beszedes
            clear waitBarUpdate;
        end
end