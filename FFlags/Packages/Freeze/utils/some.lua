-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: function) -- Line: 3
    for i, v in p1 do
        if p2(v, i) == true then
            return true;
        end;
    end;

    return false;
end;