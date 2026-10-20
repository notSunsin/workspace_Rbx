-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: number?) -- Line: 20, Name: pop
    -- upvalues: maybeFreeze (copy)
    local math_max_ret = math.max(1, p2 or 1);
    local v3 = #p1;
    local table_create_ret = table.create(v3);

    for i = 1, v3 - math_max_ret do
        table_create_ret[i] = p1[i];
        local _ = i;
    end;

    return maybeFreeze(table_create_ret);
end;