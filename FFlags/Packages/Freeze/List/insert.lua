-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: number, ...) -- Line: 16, Name: insert
    -- upvalues: maybeFreeze (copy)
    local v3 = #p1;

    if p2 < 1 then
        p2 = v3 + p2;
    end;

    local math_clamp_ret = math.clamp(p2, 1, v3 + 1);
    local v4 = {};
    local v5 = 1;

    for i = 1, v3 + 1 do
        local v6;

        if i == math_clamp_ret then
            v6 = i;

            for i2 = 1, select("#", ...) do
                v4[v5] = select(i2, ...);
                v5 = v5 + 1;
                local _ = i2;
            end;
        else
            v6 = i;
        end;

        v4[v5] = p1[v6];
        v5 = v5 + 1;
    end;

    return maybeFreeze(v4);
end;