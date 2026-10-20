-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: function) -- Line: 16, Name: filter
    -- upvalues: maybeFreeze (copy)
    local table_create_ret = table.create(#p1);

    for i, v in p1 do
        if p2(v, i) then
            table.insert(table_create_ret, v);
        end;
    end;

    return maybeFreeze(table_create_ret);
end;