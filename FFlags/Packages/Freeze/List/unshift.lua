-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, ...) -- Line: 14, Name: unshift
    -- upvalues: maybeFreeze (copy)
    local v2 = select("#", ...);
    local table_clone_ret = table.clone(p1);

    for i = v2, 1, -1 do
        local v3 = select(i, ...);
        table.insert(table_clone_ret, 1, v3);
        local _ = i;
    end;

    return maybeFreeze(table_clone_ret);
end;