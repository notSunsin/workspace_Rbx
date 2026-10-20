-- Decompiled with Potassium's decompiler.

local findPair = require(script.Parent.findPair);

return function(p1: table, p2: any) -- Line: 3
    -- upvalues: findPair (copy)
    local v3, _ = findPair(p1, p2);

    return v3;
end;