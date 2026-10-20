-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: function) -- Line: 3
    local v3 = {};

    for i, v in p1 do
        local v4, v5 = p2(v, i);

        if v5 == nil then
            v5 = i;
        end;

        if v4 ~= nil then
            v3[v5] = v4;
        end;
    end;

    return v3;
end;