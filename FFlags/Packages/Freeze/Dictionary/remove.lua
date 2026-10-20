-- Decompiled with Potassium's decompiler.

local set = require(script.Parent.Parent.utils.set);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, ...) -- Line: 18, Name: remove
    -- upvalues: set (copy), maybeFreeze (copy)
    local table_clone_ret = table.clone(p1);

    for _, v in { ... } do
        table_clone_ret = set(table_clone_ret, v, nil);
    end;

    return maybeFreeze(table_clone_ret);
end;