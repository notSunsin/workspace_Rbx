-- Decompiled with Potassium's decompiler.

local slice = require(script.Parent.slice);

return function(p1: table, p2: number) -- Line: 15, Name: take
    -- upvalues: slice (copy)
    return slice(p1, 1, (math.max(1, p2)));
end;