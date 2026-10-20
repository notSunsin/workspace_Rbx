-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: number, p3: any) -- Line: 17, Name: set
    -- upvalues: maybeFreeze (copy)
    if p1[p2] == p3 then
        return p1;
    end;

    local table_clone_ret = table.clone(p1);
    table_clone_ret[p2] = p3;

    return maybeFreeze(table_clone_ret);
end;