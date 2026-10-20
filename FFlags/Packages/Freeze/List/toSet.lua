-- Decompiled with Potassium's decompiler.

return function(p1: table) -- Line: 10
    local v2 = {};

    for _, v in p1 do
        v2[v] = true;
    end;

    return v2;
end;