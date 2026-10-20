-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table) -- Line: 14, Name: flip
    -- upvalues: maybeFreeze (copy)
    local v2 = {};

    for i, v in p1 do
        v2[v] = i;
    end;

    return maybeFreeze(v2);
end;