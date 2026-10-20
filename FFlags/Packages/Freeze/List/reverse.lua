-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table) -- Line: 14, Name: reverse
    -- upvalues: maybeFreeze (copy)
    local v2 = #p1;
    local table_create_ret = table.create(v2);
    local v3 = v2 + 1;

    for i, _ in p1 do
        table_create_ret[i] = p1[v3 - i];
    end;

    return maybeFreeze(table_create_ret);
end;