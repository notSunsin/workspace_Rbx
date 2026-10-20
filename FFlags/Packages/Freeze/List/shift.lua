-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: number?) -- Line: 17, Name: shift
    -- upvalues: maybeFreeze (copy)
    local v3 = #p1;
    local math_min_ret = math.min(v3, p2 or 1);
    local table_create_ret = table.create(v3 - math_min_ret);

    for i = math_min_ret + 1, v3 do
        table_create_ret[i - math_min_ret] = p1[i];
        local _ = i;
    end;

    return maybeFreeze(table_create_ret);
end;