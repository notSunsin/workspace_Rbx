-- Decompiled with Potassium's decompiler.

return function(p1: any, p2: number?, p3: number?) -- Line: 2, Name: slice
    local v4 = #p1;
    local v5 = (not p2 or p2 >= 0) and (p2 or 1) or v4 + (p2 + 1);
    local v6;

    if p3 and p3 < 0 then
        v6 = v4 + p3;
    else
        v6 = p3 or v4;
    end;

    if v5 == 1 and v6 == #p1 then
        return p1;
    end;

    local v7 = {};
    local v8 = 1;

    for i = v5, v6 do
        v7[v8] = p1[i];
        v8 = v8 + 1;
        local _ = i;
    end;

    return v7;
end;