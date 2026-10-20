-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table) -- Line: 14, Name: keys
    -- upvalues: maybeFreeze (copy)
    local v2 = {};

    for i, _ in p1 do
        table.insert(v2, i);
    end;

    return maybeFreeze(v2);
end;