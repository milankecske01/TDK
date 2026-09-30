

% frissít egy waitbar-t, akkor érdemes használni, ha multithreadinget haszná
% lunk.
function waitBarUpdate(f, total)
    persistent darab;
    if isempty(darab) || darab == total
        darab = 1;
    else
        darab = darab + 1;
    end
    if isvalid(f)
        waitbar(darab / total, f, sprintf('%d / %d', darab, total));
    end
end