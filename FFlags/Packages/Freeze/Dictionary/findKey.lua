-- Decompiled with Potassium's decompiler.

local findPair = require(script.Parent.Parent.utils.findPair);

return function(p1: table, p2: function, p3: any) -- Line: 17, Name: findKey
    -- upvalues: findPair (copy)
    local v4, _ = findPair(p1, p2);

    if v4 == nil then
        return p3;
    end;

    return v4;
end;