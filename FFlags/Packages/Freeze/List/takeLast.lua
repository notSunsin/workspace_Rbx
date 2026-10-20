-- Decompiled with Potassium's decompiler.

local slice = require(script.Parent.slice);

return function(p1: table, p2: number) -- Line: 14, Name: takeLast
    -- upvalues: slice (copy)
    return slice(p1, -math.max(1, p2));
end;