-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(...) -- Line: 19, Name: zip
    -- upvalues: maybeFreeze (copy)
    local v1 = select(1, ...);
    local v2 = {};
    local v3 = select("#", ...);

    if v3 <= 0 then
        return v2;
    end;

    local v4 = #v1;

    for i = 2, v3 do
        local v5 = #select(i, ...);
        local v6;

        if v5 < v4 then
            v4 = v5;
            v6 = i;
        else
            v6 = i;
        end;
    end;

    for i = 1, v4 do
        v2[i] = {};
        local v7 = i;

        for i2 = 1, v3 do
            local v8 = select(i2, ...);
            v2[v7][i2] = v8[v7];
            local _ = i2;
        end;
    end;

    return maybeFreeze(v2);
end;