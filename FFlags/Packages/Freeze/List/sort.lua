-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: function?) -- Line: 16, Name: sort
    -- upvalues: maybeFreeze (copy)
    local table_clone_ret = table.clone(p1);
    table.sort(table_clone_ret, p2);

    return maybeFreeze(table_clone_ret);
end;