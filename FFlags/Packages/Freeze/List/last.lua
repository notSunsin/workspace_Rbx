-- Decompiled with Potassium's decompiler.

local get = require(script.Parent.get);

return function(p1: table, p2: any) -- Line: 20, Name: last
    -- upvalues: get (copy)
    return get(p1, -1, p2);
end;