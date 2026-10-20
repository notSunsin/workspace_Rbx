-- Decompiled with Potassium's decompiler.

local slice = require(script.Parent.slice);

return function(p1: table) -- Line: 17, Name: butLast
    -- upvalues: slice (copy)
    return slice(p1, 1, -1);
end;