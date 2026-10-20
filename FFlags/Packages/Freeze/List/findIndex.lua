-- Decompiled with Potassium's decompiler.

local findPair = require(script.Parent.Parent.utils.findPair);

return function(p1: table, p2: function) -- Line: 17, Name: findIndex
    -- upvalues: findPair (copy)
    local v3, _ = findPair(p1, p2);

    return v3;
end;