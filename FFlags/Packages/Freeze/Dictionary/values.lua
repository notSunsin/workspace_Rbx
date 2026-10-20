-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table) -- Line: 14, Name: values
    -- upvalues: maybeFreeze (copy)
    local v2 = {};

    for _, v in p1 do
        table.insert(v2, v);
    end;

    return maybeFreeze(v2);
end;