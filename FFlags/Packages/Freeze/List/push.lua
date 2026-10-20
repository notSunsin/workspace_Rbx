-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, ...) -- Line: 14, Name: push
    -- upvalues: maybeFreeze (copy)
    if #{ ... } == 0 then
        return p1;
    end;

    local table_clone_ret = table.clone(p1);

    for _, v in { ... } do
        table.insert(table_clone_ret, v);
    end;

    return maybeFreeze(table_clone_ret);
end;