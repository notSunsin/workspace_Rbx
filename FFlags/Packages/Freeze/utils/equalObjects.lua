-- Decompiled with Potassium's decompiler.

return function(...) -- Line: 2, Name: equalObjects
    local v1 = select(1, ...);

    for i = 2, select("#", ...) do
        if v1 ~= select(i, ...) then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;