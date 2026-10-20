-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: function?) -- Line: 3, Name: count
    local v3 = 0;

    for i, v in p1 do
        if p2 == nil or p2(v, i) then
            v3 = v3 + 1;
        end;
    end;

    return v3;
end;