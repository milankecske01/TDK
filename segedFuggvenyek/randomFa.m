%Random fát generál úgy, hogy minden lehetséges fa ugyanakkora eséllyel jelenik meg
%Működés:
% ha egy fának n belső csomópontja van, akkor a lehetséges fák számát a Catalan szám
% adja meg C_n = (1/(n+1))*binom(2n,n)
%Ezután rekurzívan
%Catalan szám alapján kiszámoljuk, hogy a bal és jobb al-fába mennyi belső csomópont
%kerüljön.
%
%n= belső csomópontok száma
function tree = randomFa(tablazat)
    n=height(tablazat)-1;
    if n < 0
        error('Legyen legalább 1 elem a táblázatban');
    end

    % Speciális eset: 0 belső csomópont -> 1 levél
    if n == 0
        tree = phytree([], tablazat.Properties.RowNames);
        return;
    end

    %előre kiszámoljuk a Catalan számok logaritmusait.
    logC = zeros(1, n+1);
    for i = 0:n
        logC(i+1) = gammaln(2*i + 1) - gammaln(i + 1) - gammaln(i + 2);
    end

    kevertLevelek = randperm(n + 1);
    levelIdSzamlalo=1;
    belsoIdSzamlalo=2+n;
    %m=belső node-ok száma
    %logC= Catalan számok logaritmusai
    function [B, gyerekId] = build_subtree(m, logC)
        % B: az eddig összegyűjtött ágmátrix sorai

        %levél
        if m == 0
            B = [];
            gyerekId = kevertLevelek(levelIdSzamlalo);
            levelIdSzamlalo=levelIdSzamlalo+1;
            return;
        end

        % súlyokat számolunk minden lehetséges bal oldali részfa méretre
        log_weights = zeros(1, m);
        for k = 1:m
            log_weights(k) = logC(k) + logC(m - k + 1);
        end

        %súlyokat skálázzuk a numerikus stabilitás érdekében (log-sum-exp trükk)
        max_log = max(log_weights);
        weights = exp(log_weights - max_log);
        cum_weights = cumsum(weights);
        total_weight = cum_weights(end);

        %random választunk egy opciót a súlyok alapján
        r = rand() * total_weight;
        idx = find(r <= cum_weights, 1, 'first');
        balReszfaDb = idx - 1;  % bal oldali részfa belső csomópontjainak száma

        % Rekurzió a bal és jobb részfákra
        [B_bal, balGyerek] = build_subtree(balReszfaDb, logC);
        [B_jobb, jobbGyerek] = build_subtree(m - 1 - balReszfaDb, logC);

        gyerekId=belsoIdSzamlalo;
        belsoIdSzamlalo=belsoIdSzamlalo+1;

        jelenlegiSor = [balGyerek, jobbGyerek];
        B = [B_bal; B_jobb; jelenlegiSor];
    end

    [B, ~] = build_subtree(n, logC);

    tree = phytree(B,tablazat.Properties.RowNames);
end

