-- Decompiled with Potassium's decompiler.

local keyOf = require(script.Parent.Parent.utils.keyOf);

return function(p1: table, p2: any) -- Line: 15, Name: indexOf
    -- upvalues: keyOf (copy)
    local v3 = keyOf(p1, p2);

    if v3 == nil then
        return nil;
    end;

    return v3;
end;