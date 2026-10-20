-- Decompiled with Potassium's decompiler.

return function(p1, p2) -- Line: 3
    for i, v in p1 do
        if p2(v, i) == false then
            return false;
        end;
    end;

    return true;
end;