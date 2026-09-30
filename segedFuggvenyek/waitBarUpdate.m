

% frissít egy waitbar-t, akkor érdemes használni, ha multithreadinget haszná
% lunk.
function waitBarUpdate(f, total)
    persistent count;
    if isempty(count) || count == total
        count = 1;
    else
        count = count + 1;
    end
    if isvalid(f)
        waitbar(count / total, f, sprintf('%d / %d', count, total));
    end
end